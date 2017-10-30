#!/bin/bash
# curl autoscan radarr webhook sender

# settings
AUTOSCAN_URL=

# args/envs
MOVIE_PATH="$radarr_moviefile_path"

# send webhook
{
/usr/bin/curl -d "eventType=Manual&filepath=$MOVIE_PATH" $AUTOSCAN_URL
} &> /dev/null
