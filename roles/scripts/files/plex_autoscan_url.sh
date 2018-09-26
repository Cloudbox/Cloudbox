#!/bin/bash
#########################################################################
# Title:         Plex Autoscan URL Script                               #
# Author(s):     Desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# Description:   Prints out the Plex Autoscan URL.                      #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
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

# Print banner
if [ -x "$(command -v toilet)" ]; then
    echo ""
    toilet 'Plex Autoscan URL' -f standard --filter metal --filter border:metal --width 86
fi

echo -e "
$GREEN┌───────────────────────────────────────────────────────────────────────────────────┐
$GREEN│ Title:             Plex Autoscan URL Script                                       │
$GREEN│ Author(s):         Desimaniac                                                     │
$GREEN│ URL:               https://github.com/cloudbox/cloudbox                           │
$GREEN│ Description:       Prints out the Plex Autoscan URL.                              │
$GREEN├───────────────────────────────────────────────────────────────────────────────────┤
$GREEN│                Part of the Cloudbox project: https://cloudbox.works               │
$GREEN├───────────────────────────────────────────────────────────────────────────────────┤
$GREEN│                        GNU General Public License v3.0                            │
$GREEN└───────────────────────────────────────────────────────────────────────────────────┘
$NORMAL"

# Config files
CB_ANSIBLE="$HOME/cloudbox/ansible.cfg"
CB_ACCOUNTS="$HOME/cloudbox/accounts.yml"
PAS_CONFIG="/opt/plex_autoscan/config/config.json"

# Sanity checks
if ! [ -x "$(command -v jq)" ]; then
    echo -e $BRED" Error: "$NORMAL"'"$BWHITE"jq"$NORMAL"' is not installed."\
    $NORMAL"Run '"$BWHITE"sudo apt-get install jq"$NORMAL"' to install." >&2
    echo ""
    exit 1
elif ! [ -x "$(command -v yq)" ]; then
    echo -e $BRED" Error: "$NORMAL"'"$BWHITE"yq"$NORMAL"' is not installed."\
    $NORMAL"Run '"$BWHITE"sudo pip install yq"$NORMAL"' to install." >&2
    echo ""
    exit 1
elif [[ ! -f $PAS_CONFIG ]]; then
    echo -e $BRED" Error: "$NORMAL"File '"$BWHITE$PAS_CONFIG$NORMAL"' is not found." >&2
    echo ""
    exit 1
elif [[ ! -f $CB_ACCOUNTS ]]; then
    echo -e $BRED" Error: "$NORMAL"File '"$BWHITE$CB_ACCOUNTS$NORMAL"' is not found." >&2
    echo ""
    exit 1
fi

# Validate JSON file
cat $PAS_CONFIG | jq -e . >/dev/null 2>&1
rc=$?
if [[ $rc != 0 ]]; then
    echo -e $BRED" Error: "$NORMAL"Invalid JSON format in '"$BWHITE$PAS_CONFIG$NORMAL"'."  >&2
    echo ""
    echo -e " See 'JSON Format Errors' on the Wiki FAQ page."  >&2
    echo ""
    exit 1
fi

# Get variable(s) from Plex Autoscan config
SERVER_IP=$(cat $PAS_CONFIG | jq -r .SERVER_IP)
SERVER_PORT=$(cat $PAS_CONFIG | jq -r .SERVER_PORT)
SERVER_PASS=$(cat $PAS_CONFIG | jq -r .SERVER_PASS)

# Get variable(s) from Cloudbox account settings
head -1 $CB_ACCOUNTS | grep -q \$ANSIBLE_VAULT
rc=$?
if [[ $rc == 0 ]]; then
    VAULT_FILE=$(cat $CB_ANSIBLE | grep vault_password_file | sed 's/^.*=//' | sed "s/ //g")
    DOMAIN=$(ansible-vault view --vault-password-file=$VAULT_FILE $CB_ACCOUNTS | yq -r .domain)
elif [[ $rc == 1 ]]; then
    DOMAIN=$(cat $CB_ACCOUNTS | yq -r .domain)
fi

# If SERVER_IP is 0.0.0.0, assign public IP address to REAL_IP.
if [ $SERVER_IP = 0.0.0.0 ]; then
    REAL_IP="$(curl -s http://checkip.amazonaws.com)"
else
    REAL_IP=$SERVER_IP
fi

# Declare Subdomains Array
declare -a SUBDOMAINS=(
    "plex.$DOMAIN"
    "mediabox.$DOMAIN"
    "cloudbox.$DOMAIN"
    "$REAL_IP"
)

# Get length of the subdomains array
SUBDOMAIN_LEN=${#SUBDOMAINS[@]}

# Declare variables for while loop
declare -i COUNT=0
SUBDOMAIN_IP=""

# Get subdomain who's IP address matches REAL_IP
while [[ (($REAL_IP != $SUBDOMAIN_IP) && ($COUNT < ${SUBDOMAIN_LEN})) ]]; do
    SUBDOMAIN=${SUBDOMAINS[$COUNT]}
    SUBDOMAIN_IP=$(dig +short ${SUBDOMAIN})
    COUNT+=1
done

# Print Plex Autoscan URL
echo -e $BWHITE"Your Plex Autoscan URL:"
echo -e $BBLUE"http://${SUBDOMAIN}:${SERVER_PORT}/${SERVER_PASS}"$NORMAL
echo ""
