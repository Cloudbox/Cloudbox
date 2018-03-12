#!/bin/sh
# autodl script: /scripts/arrpush.legacy.sh
# autodl args: sonarr "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"
# or
# autodl args: radarr "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"


# settings
sonarrUrl=http://sonarr:8989/api/release/push
sonarrApiKey=YOUR_API_KEY
radarrUrl=http://radarr:7878/api/release/push
radarrApiKey=YOUR_API_KEY

# args
type=$1
title=$2
downloadUrl=$3
indexer=$5
date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# funcs
get_release_name() {
  echo $(curl -X HEAD -sI "$1" | grep -oE 'filename=.*$' | sed -e 's/^filename="\(.*\)\.[0-9]*\.torrent"\s*$/\1/')
}

# Calculate provided size into bytes
size=$(echo $4 | awk '/[0-9.]$/{print $1;next};/ MB$/{printf "%u", $1*(1024*1024);next};/ GB$/{printf "%u", $1*1024*1024*1024;next}')

# parse release name from download link headers, for the trackers that do not provide it in their announcements... (looking at you PTP)
if [ $indexer = "PassThePopcorn" ]; then
  title=$(get_release_name $downloadUrl)
fi

# push to sonarr/radarr
if [ $type = "sonarr" ]; then
  {
    /usr/local/bin/curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "X-Api-Key: $sonarrApiKey" -X POST -d '{"title":"'"$title"'","downloadUrl":"'"$downloadUrl"'","size":"'"$size"'","indexer":"'"$indexer"'","downloadProtocol":"torrent","publishDate":"'"$date"'"}' $sonarrUrl
  } > /dev/null 2>&1

elif [ $type = "radarr" ]; then
  {
    /usr/local/bin/curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "X-Api-Key: $radarrApiKey" -X POST -d '{"title":"'"$title"'","downloadUrl":"'"$downloadUrl"'","size":"'"$size"'","indexer":"'"$indexer"'","downloadProtocol":"torrent","publishDate":"'"$date"'"}' $radarrUrl
  } > /dev/null 2>&1

else
  echo "Unknown type: $type"
fi
