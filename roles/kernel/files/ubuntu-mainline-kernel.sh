#!/usr/bin/env bash


[ -f "/etc/os-release" ] && {
    source /etc/os-release
    [[ "$ID" == "ubuntu" ]] || [[ "$ID_LIKE" =~ "ubuntu" ]]
} || {
    OS=$(lsb_release -si 2>&-)
    [[ "$OS" == "Ubuntu" ]] || [[ "$OS" == "LinuxMint" ]]  || [[ "$OS" == "neon" ]] || { 
        echo "Abort, this script is only intended for Ubuntu-like distro's"
        exit 2
    }
}

#default values
ppa_host="kernel.ubuntu.com"
ppa_index="/~kernel-ppa/mainline/"
ppa_key="17C622B0"

quite=0
cleanup_files=1
do_install=1
use_lowlatency=0
use_lpae=0
use_rc=0
# signed_only=0
check_signature=1
check_checksum=1
assume_yes=0
LOCAL_VERSIONS=()
REMOTE_VERSIONS=()
run_action="help"
action_data=()
debug_target="/dev/null"
workdir="/tmp/$(basename "$0")/"
sudo=$(command -v sudo)
ARCH=$(dpkg --print-architecture)
monitor_pid=0
download_size=0

# helper functions
single_action () {
    [ "$run_action" != "help" ] && {
        err "Abort, only one argument can be supplied. See -h"
        exit 2
    }
}

log () {
    [ $quite -eq 0 ] && echo "$@"
}

logn () {
    [ $quite -eq 0 ] && echo -n "$@"
}

warn () {
    [ $quite -eq 0 ] && echo "$@" >&2
}

err () {
    echo "$@" >&2
}

#parse options
while (( "$#" )); do
    argarg_required=0
    
    case $1 in
        -c|--check)
            single_action
            run_action="check"
            ;;
        -l|--local-list)
            single_action
            run_action="local-list"
            argarg_required=1
            ;;
        -r|--remote-list)
            single_action
            run_action="remote-list"
            argarg_required=1
            ;;
        -i|--install)
            single_action
            run_action="install"
            argarg_required=1
            ;;
        -u|--uninstall)
            single_action
            run_action="uninstall"
            argarg_required=1
            ;;
        -p|--path)
            if [ -z "$2" ] || [ "${2##-}" != "$2" ]; then
                err "Option $1 requires an argument."
                exit 2
            else
                workdir="$2"
                shift
                
                if [ ! -d "$workdir" ]; then
                    mkdir -p "$workdir";
                fi
                
                if [ ! -d "$workdir" ] || [ ! -w "$workdir" ]; then    
                    err "$workdir is not writable"
                    exit 1
                fi
                
                cleanup_files=0
            fi
            ;;
        -ll|--lowlatency|--low-latency)
            [[ "$ARCH" != "amd64" ]] && [[ "$ARCH" != "i386" ]] && { 
                err "Low-latency kernels are only available for amd64 or i386 architectures"
                exit 3
            }
            
            use_lowlatency=1
            ;;
        -lpae|--lpae)
            [[ "$ARCH" != "armhf" ]] && { 
                err "Large Physical Address Extension (LPAE) kernels are only available for the armhf architecture"
                exit 3
            }
            
            use_lpae=1
            ;;
        --rc)
            use_rc=1
            ;;
        -s|--signed)
            # signed_only=1
            log "The option '--signed' is not yet implemented"
            ;;
        --yes)
            assume_yes=1
            ;;
        -q|--quite)
            [ "$debug_target" == "/dev/null" ] && { quite=1; }
            ;;
        -do|--download-only)
            do_install=0
            cleanup_files=0
            ;;
        -ns|--no-signature)
            check_signature=0
            ;;
        -nc|--no-checksum)
            check_checksum=0
            ;;
        -d|--debug)
            debug_target="/dev/stderr"
            quite=0
            ;;
        -h|--help)
            run_action="help"
            ;;
        *)
            run_action="help"
            err "Unknown argument $1"
            ;;
    esac
    
    if [ $argarg_required -eq 1 ]; then
        [ -n "$2" ] && [ "${2##-}" == "$2" ] && {
            action_data+=("$2")
            shift
        }
    elif [ $argarg_required -eq 2 ]; then
        [ -n "$2" ] && [ "${2##-}" == "$2" ] && { 
            action_data+=("$2")
            shift
        } || {
            err "Option $1 requires an argument"
            exit 2
        }
    fi
    
    shift
done

# internal functions
containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] || [[ "$e" =~ $1- ]] && return 0; done
  return 1
}

download () {
    host=$1
    uri=$2

    exec 3<>/dev/tcp/"$host"/80
    echo -e "GET $uri HTTP/1.0\r\nHost: $host\r\nConnection: close\r\n\r\n" >&3
    cat <&3
}

monitor_progress () {
    local msg=$1
    local file=$2

    download_size=-1
    printf "%s: " "$msg"
    (while :; do for c in / - \\ \|; do
        [[ -f "$file" ]] && {
            [[ $download_size -le 0 ]] && {
                download_size=$(($(head -n20 "$file" | grep -aoi -E "Content-Length: [0-9]+" | cut -d" " -f2) + 0))
                printf ' %d%% %s' 0 "$c"
                printf '\b%.0s' {1..5}
            } || {
                filesize=$(( $(du -b "$file" | cut -f1) + 0))
                progress="$((200*filesize/download_size % 2 + 100*filesize/download_size))"

                printf ' %s%% %s' "$progress" "$c"
                length=$((4 + ${#progress}))
                printf '\b%.0s' $(seq 1 $length)
            }
        }
        sleep 1
    done; done) &
    monitor_pid=$!
}

end_monitor_progress () {
    { kill $monitor_pid && wait $monitor_pid; printf '100%%   \n'; } 2>/dev/null
}

remove_http_headers () {
    file="$1"
    nr=0
    while(true); do
        nr=$((nr + 1))
        line=$(head -n$nr "$file" | tail -n 1)

        if [ -z "$(echo "$line" | tr -cd '\r\n')" ]; then
            tail -n +$nr "$file" > "${file}.tmp"
            mv "${file}.tmp" "${file}"
            break
        fi
        
        [ $nr -gt 100 ] && {
            err "Abort, could not remove http headers from file"
            exit 500
        }
    done
}

load_local_versions() {
    local version
    if [ ${#LOCAL_VERSIONS[@]} -eq 0 ]; then
        IFS=$'\n'
        for pckg in $(dpkg -l linux-image-* | cut -d " " -f 3 | sort); do
            # only match kernels from ppa
            if [[ "$pckg" =~ linux-image-[0-9]+\.[0-9]+\.[0-9]+-[0-9]{6} ]]; then
                version="v"$(echo "$pckg" | cut -d"-" -f 3,4)

                LOCAL_VERSIONS+=("$version")
            fi
        done
        unset IFS
    fi
}

latest_local_version() {
    load_local_versions 1

    if [ ${#LOCAL_VERSIONS[@]} -gt 0 ]; then
        local sorted
        IFS=$'\n'
        sorted=($(sort -t"." -k1V,3 <<<"${LOCAL_VERSIONS[*]}"))
        unset IFS

        lv="${sorted[${#sorted[@]}-1]}"
        echo "${lv/-[0-9][0-9][0-9][0-9][0-9][0-9]rc/-rc}"
    else
        echo "none"
    fi
}

load_remote_versions () {
    local line
    if [ ${#REMOTE_VERSIONS[@]} -eq 0 ]; then
        [ -z "$1" ] && logn "Downloading index from $ppa_host"
        index=$(download $ppa_host $ppa_index)
        [ -z "$1" ] && log

        IFS=$'\n'
        for line in $index; do
            [[ "$line" =~ "folder" ]] || continue
            [[ $use_rc -eq 0 ]] && [[ "$line" =~ -rc ]] && continue
            [[ "$line" =~ v[0-9]+\.[0-9]+(\.[0-9]+)?(-rc[0-9]+)?/ ]] || continue
            
            line=${line##*href=\"}
            line=${line%%\/\">*}
            [[ ! "$line" =~ (v[0-9]+\.[0-9]+)\.[0-9]+ ]] && [[ "$line" =~ (v[0-9]+\.[0-9]+)(-rc[0-9]+)? ]] && line=${BASH_REMATCH[1]}".0"${BASH_REMATCH[2]}

            REMOTE_VERSIONS+=("$line")
        done
        unset IFS
    fi
}

latest_remote_version () {
    load_remote_versions 1
    local sorted

    sorted=($(sort -t"." -k1V,3 <<<"${REMOTE_VERSIONS[*]}" | tr '\n' ' '))

    echo "${sorted[${#sorted[@]}-1]}"
}

# execute requested action
case $run_action in
    help)
        echo "Usage: $0 -c|-l|-r|-u

Download & install the latest kernel available from $ppa_host$ppa_uri

Arguments:
  -c               Check if a newer kernel version is available
  -i [VERSION]     Install kernel VERSION, see -l for list. You dont have to prefix
                   with v. E.g. -i 4.9 is the same as -i v4.9. If version is
                   omitted the latest available version will be installed
  -l [SEARCH]      List locally installedkernel versions. If an argument to this
                   option is supplied it will search for that
  -r [SEARCH]      List available kernel versions. If an argument to this option
                   is supplied it will search for that
  -u [VERSION]     Uninstall the specified kernel version. If version is omitted,
                   a list of max 10 installed kernel versions is displayed
  -h               Show this message

Optional:
  -s, --signed         Only install signed kernel packages (not implemented)
  -p, --path DIR       The working directory, .deb files will be downloaded into 
                       this folder. If omitted, the folder /tmp/$(basename "$0")/
                       is used. Path is relative from \$PWD
  -ll, --low-latency   Use the low-latency version of the kernel, only for amd64 & i386
  -lpae, --lpae        Use the Large Physical Address Extension kernel, only for armhf
  -do, --download-only Only download the deb files, do not install them
  -ns, --no-signature  Do not check the gpg signature of the checksums file
  -nc, --no-checksum   Do not check the sha checksums of the .deb files
  -d, --debug          Show debug information, all internal command's echo their output
  --rc                 Also include release candidates
  --yes                Assume yes on all questions (use with caution!)
"
        exit 2
        ;;

    check)
        logn "Finding latest version available on $ppa_host"
        latest_version=$(latest_remote_version)
        log ": $latest_version"
        
        logn "Finding latest installed version"
        installed_version=$(latest_local_version)
        log ": $installed_version"

        if [ "$installed_version" != "$latest_version" ] && [ "$installed_version" = "$(echo -e "$latest_version\n$installed_version" | sort -V | head -n1)" ]; then
            log "A newer kernel version ($latest_version) is available"
            
            [ -x "$(command -v notify-send)" ] && notify-send --icon=info -t 12000 \
                "Kernel $latest_version available" \
                "A newer kernel version ($latest_version) is\navailable on $ppa_host$ppa_uri\n\nRun '$(basename "$0") -i' to update"
            exit 1
        fi
        ;;
    local-list)
        load_local_versions
        
        [[ -n "$(command -v column)" ]] && { column="column -x"; } || { column="cat"; }
        
        (for version in "${LOCAL_VERSIONS[@]}"; do
            if [ -z "${action_data[0]}" ] || [[ "$version" =~ ${action_data[0]} ]]; then
                echo "$version"
            fi
        done) | $column
        ;;
    remote-list)
        load_remote_versions
        
        [[ -n "$(command -v column)" ]] && { column="column -x"; } || { column="cat"; }
        
        (for version in "${REMOTE_VERSIONS[@]}"; do
            if [ -z "${action_data[0]}" ] || [[ "$version" =~ ${action_data[0]} ]]; then
                echo "$version"
            fi
        done) | $column
        ;;
    install)
        load_local_versions
        
        if [ -z "${action_data[0]}" ]; then
            logn "Finding latest version available on $ppa_host"
            version=$(latest_remote_version)
            log
            
            if containsElement "$version" "${LOCAL_VERSIONS[@]}"; then
                logn "Latest version is $version but seems its already installed"
            else
                logn "Latest version is: $version"
            fi
                
            if [ $do_install -gt 0 ] && [ $assume_yes -eq 0 ];then
                logn ", continue? (y/N) "
                [ $quite -eq 0 ] && read -rsn1 continue
                log
                
                [ "$continue" != "y" ] && [ "$continue" != "Y" ] && { exit 0; }
            else
                log
            fi
        else
            load_remote_versions
            
            version=""
            if containsElement "v${action_data[0]#v}" "${REMOTE_VERSIONS[@]}"; then
                version="v"${action_data[0]#v}
            fi
            
            [[ -z "$version" ]] && {
                err "Version '${action_data[0]}' not found"
                exit 2
            }
            shift
            
            if [ $do_install -gt 0 ] && containsElement "$version" "${LOCAL_VERSIONS[@]}" && [ $assume_yes -eq 0 ]; then
                logn "It seems version $version is already installed, continue? (y/N) "
                [ $quite -eq 0 ] && read -rsn1 continue
                log
                
                [ "$continue" != "y" ] && [ "$continue" != "Y" ] && { exit 0; }
            fi
        fi
        
        [ ! -d "$workdir" ] && { 
            mkdir -p "$workdir" 2>/dev/null
        }
        [ ! -x "$workdir" ] && {
            err "$workdir is not writable"
            exit 1
        }
        
        cd "$workdir" || exit 1
        
        [ $check_signature -eq 1 ] && [ -z "$(command -v gpg)" ] && {
            check_signature=0
            
            warn "Disable signature check, gpg not available"
        }

        if [ $check_signature -eq 0 ]; then
            FILES=()
        else
            FILES=("CHECKSUMS" "CHECKSUMS.gpg")
        fi

        IFS=$'\n'

        ppa_uri=$ppa_index${version%\.0}"/"
        ppa_uri=${ppa_uri/\.0-rc/-rc}

        index=$(download $ppa_host "$ppa_uri")
        index=${index##*<table}
        for line in $index; do
            [[ "$line" =~ linux-(image(-(un)?signed)?|headers|modules)-[0-9]+\.[0-9]+\.[0-9]+-[0-9]{6}.*?_(${ARCH}|all).deb ]] || continue
            
            [ $use_lowlatency -eq 0 ] && [[ "$line" =~ "-lowlatency" ]] && continue
            [ $use_lowlatency -eq 1 ] && [[ ! "$line" =~ "-lowlatency" ]] && [[ ! "$line" =~ "_all" ]] && continue
            [ $use_lpae -eq 0 ] && [[ "$line" =~ "-lpae" ]] && continue
            [ $use_lpae -eq 1 ] && [[ ! "$line" =~ "-lpae" ]] && [[ ! "$line" =~ "_all" ]] && continue
            
            line=${line##*href=\"}
            line=${line%%\">*}
            
            FILES+=("$line")
        done
        unset IFS

        debs=()
        log "Will download ${#FILES[@]} files from $ppa_host:"
        for file in "${FILES[@]}"; do
            monitor_progress "Downloading $file" "$workdir$file"
            download $ppa_host "$ppa_uri$file" > "$workdir$file"
            
            remove_http_headers "$workdir$file"
            end_monitor_progress
            
            if [[ "$file" =~ \.deb ]]; then
                debs+=("$file")
            fi
        done

        if [ $check_signature -eq 1 ]; then
            if ! gpg --list-keys ${ppa_key} >$debug_target 2>&1; then
                logn "Importing kernel-ppa gpg key "
                
                if gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv ${ppa_key} >$debug_target 2>&1; then
                    log "ok"
                else
                    logn "failed"
                    warn "Unable to check signature"
                    check_signature=0
                fi
            fi

            if [ $check_signature -eq 1 ]; then
                if gpg --verify CHECKSUMS.gpg CHECKSUMS >$debug_target 2>&1; then
                    log "Signature of checksum file has been succesfully verified"
                else
                    err "Abort, signature of checksum file is NOT OK"
                    exit 4
                fi
            fi
        fi

        if [ $check_checksum -eq 1 ]; then
            shasums=( "sha256sum" "sha1sum" )
            
            for shasum in "${shasums[@]}"; do
                xshasum=$(command -v "$shasum")
                if [ -n "$xshasum" ] && [ -x "$xshasum" ]; then
                    shasum_result=$($xshasum --ignore-missing -c CHECKSUMS 2>>$debug_target | tee -a $debug_target | wc -l)

                    if [ "$shasum_result" -eq 0 ] || [ "$shasum_result" -ne ${#debs[@]} ]; then
                        err "Abort, $shasum retuned an error $shasum_result"
                        exit 4
                    else
                        log "Checksums of deb files have been succesfully verified with $shasum"
                    fi

                    break
                fi
            done
        fi

        if [ $do_install -eq 1 ]; then
            if [ ${#debs[@]} -gt 0 ]; then
                log "Installing ${#debs[@]} packages"
                $sudo dpkg -i "${debs[@]}" >$debug_target 2>&1
            else
                warn "Did not find any .deb files to install"
            fi
        else
            log "deb files have been saved to $workdir"
        fi

        if [ $cleanup_files -eq 1 ]; then
            log "Cleaning up work folder"
            rm -f "$workdir"*.deb
            rm -f "$workdir"CHECKSUM*
            rmdir "$workdir"
        fi
        ;;
    uninstall)
        load_local_versions

        if [ ${#LOCAL_VERSIONS[@]} -eq 0 ]; then
            echo "No installed mainline kernels found"
            exit 1
        elif [ -z "${action_data[0]}" ]; then
            echo "Which kernel version do you wish to uninstall?"
            nr=0
            for version in "${LOCAL_VERSIONS[@]}"; do
                echo "[$nr]: $version"
                nr=$((nr + 1))
                
                [ $nr -gt 9 ] && break
            done
            
            echo -n "type the number between []: "
            read -rn1 index
            echo ""
            
            uninstall_version=${LOCAL_VERSIONS[$index]}
        elif containsElement "v${action_data[0]#v}" "${LOCAL_VERSIONS[@]}"; then
            uninstall_version="v"${action_data[0]#v}
        else
            err "Kernel version ${action_data[0]} not installed locally"
            exit 2
        fi

        if [ $assume_yes -eq 0 ]; then
            echo -n "Are you sure you wish to remove kernel version $uninstall_version? (y/N)"
            read -rsn1 continue
            echo ""
        else
            continue="y"
        fi
        
        if [ "$continue" == "y" ] || [ "$continue" == "Y" ]; then
            IFS=$'\n'
            
            pckgs=()
            for pckg in $(dpkg -l linux-{image,image-[un]?signed,headers,modules}-"${uninstall_version#v}"* 2>$debug_target | cut -d " " -f 3); do
                # only match kernels from ppa, they have 6 characters as second version string
                if [[ "$pckg" =~ linux-headers-[0-9]+\.[0-9]+\.[0-9]+-[0-9]{6} ]]; then
                    pckgs+=("$pckg:$ARCH")
                    pckgs+=("$pckg:all")
                elif [[ "$pckg" =~ linux-(image(-(un)?signed)?|modules)-[0-9]+\.[0-9]+\.[0-9]+-[0-9]{6} ]]; then
                    pckgs+=("$pckg:$ARCH")
                fi
            done    
            
            if [ ${#pckgs[@]} -eq 0 ]; then
                warn "Did not find any packages to remove"
            else
                echo "The following packages will be removed: "
                echo "${pckgs[@]}"
                
                if [ $assume_yes -eq 0 ]; then
                    echo -n "Are you really sure? Do you still have another kernel installed? (y/N)"
                    
                    read -rsn1 continue
                    echo ""
                else
                    continue="y"
                fi
                
                if [ "$continue" == "y" ] || [ "$continue" == "Y" ]; then
                    if $sudo DEBIAN_FRONTEND=noninteractive dpkg --purge "${pckgs[@]}" 2>$debug_target >&2; then
                        log "Kernel $uninstall_version succesfully purged"
                        exit 0
                    fi
                fi
            fi
        fi
        ;;
esac

exit 0
