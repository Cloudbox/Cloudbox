#!/usr/bin/env bash
#########################################################################
# Title:         Plex Autoscan URL Script                               #
# Author(s):     desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# Description:   Prints out the Plex Autoscan URL.                      #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

################################
# Constants
################################

# Regular colors
readonly NORMAL="\033[0;39m"
readonly GREEN="\033[32m"

# Bold colors
readonly BRED="\033[1;31m"
readonly BWHITE="\033[1;37m"
readonly BBLUE="\033[1;34m"

# Config files
readonly CB_ANSIBLE="${HOME}/cloudbox/ansible.cfg"
readonly CB_ACCOUNTS="${HOME}/cloudbox/accounts.yml"
readonly PAS_CONFIG="/opt/plex_autoscan/config/config.json"

# Boolean vars
readonly TRUE=1
readonly FALSE=0

################################
# Functions
################################

function banner1() {
    if [ -x "$(command -v toilet)" ]; then
        echo ""
        toilet 'Plex Autoscan URL' -f standard --filter metal --filter border:metal --width 86
    fi
}

function banner2() {
echo -e "
${GREEN}┌───────────────────────────────────────────────────────────────────────────────────┐
${GREEN}│ Title:             Plex Autoscan URL Script                                       │
${GREEN}│ Author(s):         desimaniac                                                     │
${GREEN}│ URL:               https://github.com/cloudbox/cloudbox                           │
${GREEN}│ Description:       Prints out the Plex Autoscan URL.                              │
${GREEN}├───────────────────────────────────────────────────────────────────────────────────┤
${GREEN}│                Part of the Cloudbox project: https://cloudbox.works               │
${GREEN}├───────────────────────────────────────────────────────────────────────────────────┤
${GREEN}│                        GNU General Public License v3.0                            │
${GREEN}└───────────────────────────────────────────────────────────────────────────────────┘
${NORMAL}"
}

function sanity_check() {
    # Sanity checks
    if ! [[ -x "$(command -v jq)" ]]; then
        echo -e ${BRED}" Error: "${NORMAL}"'"${BWHITE}"jq"${NORMAL}"' is not installed."\
        ${NORMAL}"Run '"${BWHITE}"sudo apt-get install jq"${NORMAL}"' to install." >&2
        echo ""
        exit 1
    elif ! [[ -x "$(command -v yq)" ]]; then
        echo -e ${BRED}" Error: "${NORMAL}"'"${BWHITE}"yq"${NORMAL}"' is not installed."\
        ${NORMAL}"Run '"${BWHITE}"sudo pip install yq"${NORMAL}"' to install." >&2
        echo ""
        exit 1
    elif [[ ! -f ${PAS_CONFIG} ]]; then
        echo -e ${BRED}" Error: "${NORMAL}"File '"${BWHITE}${PAS_CONFIG}${NORMAL}"' is not found." >&2
        echo ""
        exit 1
    elif [[ ! -f ${CB_ACCOUNTS} ]]; then
        echo -e ${BRED}" Error: "${NORMAL}"File '"${BWHITE}${CB_ACCOUNTS}${NORMAL}"' is not found." >&2
        echo ""
        exit 1
    fi

    # Validate JSON file
    cat ${PAS_CONFIG} | jq -e . >/dev/null 2>&1
    rc=$?
    if [[ $rc != 0 ]]; then
        echo -e ${BRED}" Error: "${NORMAL}"Invalid JSON format in '"${BWHITE}${PAS_CONFIG}${NORMAL}"'."  >&2
        echo ""
        echo -e " See 'JSON Format Errors' on the Wiki FAQ page."  >&2
        echo ""
        exit 1
    fi
}

function build_url() {
    # Get variables from Plex Autoscan config
    SERVER_IP=$(cat ${PAS_CONFIG} | jq -r .SERVER_IP)
    SERVER_PORT=$(cat ${PAS_CONFIG} | jq -r .SERVER_PORT)
    SERVER_PASS=$(cat ${PAS_CONFIG} | jq -r .SERVER_PASS)

    # Get variables from Cloudbox account settings
    head -1 ${CB_ACCOUNTS} | grep -q "\$ANSIBLE_VAULT"
    rc=$?
    if [[ ${rc} == 0 ]]; then
        VAULT_FILE=$(cat ${CB_ANSIBLE} | grep "^vault_password_file" | sed 's/^.*=//' | sed "s/ //g")
        DOMAIN=$(ansible-vault view --vault-password-file=${VAULT_FILE} ${CB_ACCOUNTS} | yq -r .user.domain)
    elif [[ ${rc} == 1 ]]; then
        DOMAIN=$(cat ${CB_ACCOUNTS} | yq -r .user.domain)
    fi

    # If SERVER_IP is 0.0.0.0, assign public IP address to REAL_IP.
    if [[ ${SERVER_IP} = 0.0.0.0 ]]; then
        REAL_IP="$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'\"' '{ print $2}')"
    else
        REAL_IP=${SERVER_IP}
    fi

    # Declare Subdomains Array
    declare -a SUBDOMAINS=(
        "plex.${DOMAIN}"
        "mediabox.${DOMAIN}"
        "cloudbox.${DOMAIN}"
        "${REAL_IP}"
    )

    # Get length of the subdomains array
    SUBDOMAIN_LEN=${#SUBDOMAINS[@]}

    # Declare variables for while loop
    declare -i COUNT=0
    SUBDOMAIN_IP=""

    # Determine which subdomain points to the actual host IP address (vs a CDN one, for example)
    while [[ ((${REAL_IP} != ${SUBDOMAIN_IP}) && (${COUNT} < ${SUBDOMAIN_LEN})) ]]; do
        SUBDOMAIN=${SUBDOMAINS[$COUNT]}
        SUBDOMAIN_IP=$(dig -4 +short ${SUBDOMAIN} @8.8.8.8)
        COUNT+=1
    done
}

# Print Plex Autoscan URL
function print_url() {

    if (( SIMPLE - 1 )); then
        echo -e ${BWHITE}"Your Plex Autoscan URL:"
        echo -e ${BBLUE}"http://${SUBDOMAIN}:${SERVER_PORT}/${SERVER_PASS}"${NORMAL}
        echo ""
    else
        echo http://${SUBDOMAIN}:${SERVER_PORT}/${SERVER_PASS}
    fi

}

################################
# Argument Parser
################################

## https://stackoverflow.com/a/39398359
SIMPLE=${FALSE}
# As long as there is at least one more argument, keep looping
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        # This flag type option will catch either -s or --simple
        -s|--simple)
        SIMPLE=${TRUE}
        ;;
        *)
        # Exit when unknown argument is passed
        echo "Unknown option '$key'"
        exit 10
        ;;
    esac
    shift
done

################################
# Main
################################

function main ()
{
    if [[ ${SIMPLE} == ${FALSE} ]]; then
        banner1
        banner2
    fi
        sanity_check
        build_url
        print_url
}

main "$@"
