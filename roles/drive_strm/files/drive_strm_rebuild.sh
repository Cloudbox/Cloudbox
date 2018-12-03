#!/usr/bin/env bash
#########################################################################
# Title:         Drive STRM Rebuild                                     #
# Author(s):     desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# Description:   Rebuilds STRMs while keeping config intact.            #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

################################
# Constants
################################

# Config files
readonly DOCKER_CONTAINER="drive_strm"
readonly APP_PATH="/opt/drive_strm"
readonly STRM_PATH="/mnt/strm"

################################
# Main
################################

# Stop Docker container
docker stop ${DOCKER_CONTAINER} >/dev/null

# Remove STRM files
rm -rf ${STRM_PATH}/*

# Remove STRM db files
rm ${APP_PATH}/*.db*

# Reset page_token
jq -c '.page_token = "1"' ${APP_PATH}/token.json >> ${APP_PATH}/tmp.$$.json && mv ${APP_PATH}/tmp.$$.json ${APP_PATH}/token.json

# Start Docker container
docker start ${DOCKER_CONTAINER} >/dev/null
