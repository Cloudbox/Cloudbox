#!/bin/bash

## Script prints the Plex Autoscan URL.
## Author: desimaniac


# Get variable(s) from Plex Autoscan config.
server_ip=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_IP'"]';)
server_port=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_PORT'"]';)
server_pass=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_PASS'"]';)

# Get variable(s) from Ansible settings.
domain="plex.$(cat $HOME/cloudbox/settings.yml | python3 -c 'import ruamel.yaml,sys;obj=ruamel.yaml.round_trip_load(sys.stdin);print (obj["'domain'"])';)"

# Print Plex Autoscan URL with domain.
echo "Plex Autoscan URL:"
echo "=================="
echo "http://${domain}:${server_port}/${server_pass}"

# If 0.0.0.0, assign real IP address.
if [ $server_ip = 0.0.0.0 ]; then
  real_ip="$(curl -s http://checkip.amazonaws.com)"
else
  real_ip=$server_ip
fi

# Get IP address of domain (will work with most TLDs)
domain_ip=$(python -c "import socket; print(socket.gethostbyname(\"$domain\"))")

# If domain's IP does not match real IP, print Plex Autoscan URL with IP Address.
if [ "$real_ip" != "$domain_ip" ]; then
  echo "http://${real_ip}:${server_port}/${server_pass} (use this if the one above does not work)"
fi
