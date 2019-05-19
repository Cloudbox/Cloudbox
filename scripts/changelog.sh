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

# Boolean vars
readonly TRUE=1
readonly FALSE=0

################################
# Functions
################################

# Cleanup
function cleanup() {
  [ ! -e $CHANGELOG ] || rm $CHANGELOG
}

# Header
function header() {
  echo \
    -e \
    "\n## [$NEXT_VERSION][] - $DATE\n" \
    >> changelog.txt
}

# List of commits
function commits() {
  git \
    log \
    --reverse \
    --pretty=format:"%s ([#%h][])" \
    develop...$PREVIOUS_VERSION | \
    sed 's/\(^[^:]*\):/- **\1**:/g' | \
    sed 's/\[skip ci\]//g' | \
    sed 's/\[minor\]//g' \
    >> $CHANGELOG
  }

# Whitespace
function whitespace() {
  echo "" >> $CHANGELOG
}

# Header Reference Link
function header_ref() {
  echo \
    -e \
    "[$NEXT_VERSION]: $REPO/compare/$PREVIOUS_VERSION...$NEXT_VERSION" \
    >> $CHANGELOG
}

# Commit Reference links
function commit_ref() {
  git \
    log \
    --reverse \
    --pretty=format:"[#%h]: $REPO/commit/%h" \
    develop...$PREVIOUS_VERSION \
    >> $CHANGELOG
}

# Display $CHANGELOG
function display() {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    cat $CHANGELOG
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    cat $CHANGELOG
  fi
}

# Open $CHANGELOG in Atom
function display_atom() {
  if [[ -x "$(command -v atom)" ]]; then
    atom $CHANGELOG
  fi
}

################################
# Argument Parser
################################

## https://stackoverflow.com/a/39398359
FULL=${TRUE}
# As long as there is at least one more argument, keep looping
while [[ $# -gt 0 ]]; do
  key="$1"
  case "$key" in
    # This flag type option will catch either -s or --simple
    -s|--simple)
      FULL=${FALSE}
    ;;
    *)
    # Exit when unknown argument is passed
    echo "Unknown option '$key'"
    exit 10
    ;;
  esac
  shift
done


################################
# Main
################################

function main ()
{
  cleanup
  if [[ ${FULL} == ${TRUE} ]]; then header; fi
  commits
  whitespace
  if [[ ${FULL} == ${TRUE} ]]; then header_ref; fi
  commit_ref
  whitespace
  display
  if [[ ${FULL} == ${TRUE} ]]; then display_atom; fi
}

main "$@"
