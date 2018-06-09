#!/bin/bash
#########################################################################
# Title:         Plex Autoscan URL Script                               #
# Author(s):     Desimaniac                                             #
# URL:           https://github.com/Cloudbox/Cloudbox                   #
# Description:   Prints out the Plex Autoscan URL.                      #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.rocks          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

# Regular color(s)
NORMAL="\033[0;39m"
GREEN="\033[32m"

# Bold color(s)
BRED="\033[1;31m"
BWHITE="\033[1;37m"
BBLUE="\033[1;34m"

if [ -x "$(command -v toilet)" ]; then
    echo " " && toilet ' Plex Autoscan URL' -f standard --filter metal --filter border:metal --width 86
fi

echo -e "
$GREEN
 ┌───────────────────────────────────────────────────────────────────────────────────┐
 │ Title:             Plex Autoscan URL Script                                       │
 │ Author(s):         Desimaniac                                                     │
 │ URL:               https://github.com/Cloudbox/Cloudbox                           │
 │ Description:       Prints out the Plex Autoscan URL.                              │
 ├───────────────────────────────────────────────────────────────────────────────────┤
 │                Part of the Cloudbox project: https://cloudbox.rocks               │
 ├───────────────────────────────────────────────────────────────────────────────────┤
 │                        GNU General Public License v3.0                            │
 └───────────────────────────────────────────────────────────────────────────────────┘
$NORMAL
"


# Config files
settings="$HOME/cloudbox/settings.yml"
pas_config="/opt/plex_autoscan/config/config.json"


# Sanity checks
if ! [ -x "$(command -v jq)" ]; then
    echo -e $BRED' Error: '$BWHITE"'jq'"$NORMAL' is not installed.'$NORMAL' Run '$BWHITE'sudo apt-get install jq'$NORMAL' to install.' >&2
    echo ""
    exit 1
elif ! [ -x "$(command -v yq)" ]; then
    echo -e $BRED' Error: '$BWHITE"'yq'"$NORMAL' is not installed.'$NORMAL' Run '$BWHITE'sudo pip install yq'$NORMAL' to install.' >&2
    echo ""
    exit 1
elif [[ ! -f $settings ]]; then
    echo -e $BRED' Error: '$NORMAL'File '"'"$BWHITE$settings$NORMAL"'"' not found.' >&2
    echo ""
    exit 1
elif [[ ! -f $pas_config ]]; then
  echo -e $BRED' Error: '$NORMAL'File '"'"$BWHITE$pas_config$NORMAL"'"' not found.' >&2
    echo ""
    exit 1
fi

# Validate JSON file
cat $pas_config | jq -e . >/dev/null 2>&1
rc=$?
if [[ $rc != 0 ]]; then
    echo -e $BRED' Error: '$NORMAL'Invalid JSON format in '$BWHITE"'$pas_config'." \
    $NORMAL'See "JSON Format Errors" on the FAQ page.'  >&2
    echo ""
    exit 1
fi

# Get variable(s) from Plex Autoscan config
server_ip=$(cat $pas_config | jq -r .SERVER_IP)
server_port=$(cat $pas_config | jq -r .SERVER_PORT)
server_pass=$(cat $pas_config | jq -r .SERVER_PASS)

# Get variable(s) from Ansible settings
domain=$(cat $settings | yq -r .domain)

# If 0.0.0.0, assign real IP address.
if [ $server_ip = 0.0.0.0 ]; then
    real_ip="$(curl -s http://checkip.amazonaws.com)"
else
    real_ip=$server_ip
fi


# Declare Subdomains Array
declare -a subdomains=(
    "plex.$domain"
    "mediabox.$domain"
    "cloudbox.$domain"
    "$real_ip"
)

# Get length of the subdomains array
subdomain_len=${#subdomains[@]}

# Declare variables for while loop
declare -i count=0
subdomain_ip=""

# Get subdomain who's IP address matches real_ip
while [[ (($real_ip != $subdomain_ip) && ($count < ${subdomain_len})) ]]; do
    subdomain=${subdomains[$count]}
    subdomain_ip=$(dig +short ${subdomain})
    count+=1
done

# Print Plex Autoscan URL
echo -e $BWHITE" Your Plex Autoscan URL is:"
echo ""
echo -e $BBLUE" http://${subdomain}:${server_port}/${server_pass}"$NORMAL
echo ""
