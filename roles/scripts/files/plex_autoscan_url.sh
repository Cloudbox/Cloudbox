#!/bin/bash

server_ip=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_IP'"]';)

if [ $server_ip = 0.0.0.0 ]; then
  plex_server_ip="$(curl -s http://checkip.amazonaws.com)"
else
  plex_server_ip=$server_ip
fi

port=$(cat /opt/plex_autoscan/config/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["'SERVER_PORT'"]';)

key=$(grep -m 1 "$port" /opt/plex_autoscan/plex_autoscan.log 2>/dev/null | sed 's:.*/::')

if [ -z "$key" ]; then
  i=1
  until [ "$key" ] || [ $i -gt 20 ]; do
    key=$(grep -m 1 "$port" /opt/plex_autoscan/plex_autoscan.log.$i 2>/dev/null | sed 's:.*/::')
    let i++
  done
  if [ -z "$key" ]; then
    echo "No Plex Autoscan token found."
    exit 1
  fi
fi


echo "http://${plex_server_ip}:${port}/${key}"
