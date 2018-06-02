#!/bin/bash
#########################################################################
# Title:         Plex Autoscan URL Printer                              #
# Author(s):     Desimaniac                                             #
# URL:           https://github.com/Cloudbox/Cloudbox                   #
# Description:   Prints out the Plex Autoscan URL.                      #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.rocks          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################


toilet 'Plex Autoscan URL' -f standard --filter metal --filter border:metal --width 85

cat <<BANNER


#####################################################################################
# Title:             Plex Autoscan URL                                              #
# Author(s):         Desimaniac                                                     #
# URL:               https://github.com/Cloudbox/Cloudbox                           #
# Description:       Prints out the Plex Autoscan URL.                              #
# --                                                                                #
#                Part of the Cloudbox project: https://cloudbox.rocks               #
#####################################################################################
#                        GNU General Public License v3.0                            #
#####################################################################################

BANNER

# Get variable(s) from Plex Autoscan config
server_ip=$(cat /opt/plex_autoscan/config/config.json | jq -r .SERVER_IP)
server_port=$(cat /opt/plex_autoscan/config/config.json | jq -r .SERVER_PORT)
server_pass=$(cat /opt/plex_autoscan/config/config.json | jq -r .SERVER_PASS)

# Get variable(s) from Ansible settings
domain=$(cat $HOME/cloudbox/settings.yml | yq -r .domain)

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
echo "Your Plex Autoscan URL is:"
echo "http://${subdomain}:${server_port}/${server_pass}"
echo ""
