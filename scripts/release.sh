#!/usr/bin/env bash

################################
# Variables
################################

readonly CHANGELOG="changelog.txt"
readonly DATE=$(date +"%Y-%m-%d")
readonly REPO="cloudbox/cloudbox"
readonly TAG=$(git describe --abbrev=0 --tags \
  | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{$NF=sprintf("%0*d", length($NF), ($NF+1)); print}')

################################
# Main
################################

set -e
[ -z "$DEBUG" ] || set -x;

NAME="${TAG}"

BODY=$(bash scripts/changelog.sh -s)

payload=$(
  jq --null-input \
     --arg tag "$TAG" \
     --arg name "$TAG" \
     --arg body "$BODY" \
     '{ tag_name: $tag, name: $name, body: $body, draft: true }'
)

response=$(
  curl --fail \
       --netrc \
       --silent \
       --location \
       --data "$payload" \
       "https://api.github.com/repos/${REPO}/releases"
)

upload_url="$(echo "$response" | jq -r .upload_url | sed -e "s/{?name,label}//")"


# Modifications by desimaniac @ github.com
#
# Source:
# https://gist.github.com/foca/38d82e93e32610f5241709f8d5720156
# Copyright (c) 2016 Nicolas Sanguinetti <hi@nicolassanguinetti.info>
