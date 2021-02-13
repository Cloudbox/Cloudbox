#!/usr/bin/with-contenv bash

#########################################################################
# Title:         Cloudbox: cont-init.d Script Runner                    #
# Author(s):     desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

scripts=$(find /config/script.d/ -name "*.sh" -type f | sort)

for script in $scripts; do
    echo "[cont-init.d script-runner] ${script}: executing... "
    bash $file
done