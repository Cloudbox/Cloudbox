#!/bin/bash
# curl autoscan radarr webhook sender

# settings

cfg_server_ip=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_IP'"]';)

if [ $cfg_server_ip = 0.0.0.0 ]; then
  server_ip="$(curl -s http://checkip.amazonaws.com)"
else
  server_ip=$cfg_server_ip
fi

server_port=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_PORT'"]';)

server_pass=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_PASS'"]';)

AUTOSCAN_URL=http://${server_ip}:${server_port}/${server_pass}

# args/envs
MOVIE_PATH="$radarr_moviefile_path"

# send webhook
{
/usr/bin/curl -d "eventType=Manual&filepath=$MOVIE_PATH" $AUTOSCAN_URL
} &> /dev/null
