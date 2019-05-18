#!/usr/bin/env bash
#########################################################################
# Title:         Changelog Builder                                      #
# Author(s):     desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# Description:   Prints out new version's changelog.                    #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

################################
# Variables
################################

# Constants
readonly CHANGELOG="changelog.txt"
readonly DATE=$(date +"%Y-%m-%d")
readonly REPO="https://github.com/cloudbox/cloudbox"
readonly PREVIOUS_VERSION=$(git describe --abbrev=0 --tags)
readonly NEXT_VERSION=$(echo $PREVIOUS_VERSION | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{$NF=sprintf("%0*d", length($NF), ($NF+1)); print}')

################################
# Main
################################

# Cleanup
[ -e $CHANGELOG ] && rm $CHANGELOG

# Header
echo \
  -e \
  "\n## [$NEXT_VERSION][] - $DATE\n" \
  >> changelog.txt

# List of commits
git \
  log \
  --reverse \
  --pretty=format:"%s ([#%h][])" \
  develop...master | \
  sed 's/\(^[^:]*\):/- **\1**:/g' | \
  sed 's/\[skip ci\]//g' | \
  sed 's/\[minor\]//g' \
  >> $CHANGELOG

# Whitespace
echo "" >> $CHANGELOG

# Header Link
echo \
  -e \
  "[$NEXT_VERSION]: $REPO/compare/$PREVIOUS_VERSION...$NEXT_VERSION" \
  >> $CHANGELOG

# List of reference links
git \
  log \
  --reverse \
  --pretty=format:"[#%h]: $REPO/commit/%h" \
  develop...master \
  >> $CHANGELOG

# Whitespace
echo "" >> $CHANGELOG

# Display $CHANGELOG
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  cat $CHANGELOG
elif [[ "$OSTYPE" == "darwin"* ]]; then
    cat $CHANGELOG
  if [ -x "$(command -v atom)" ]; then
    atom $CHANGELOG
  fi
fi
