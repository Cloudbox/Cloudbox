#!/bin/bash
#########################################################################
# Title:         Cloudbox: Plex Library Cron Helper Script              #
# Author(s):     Desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.rocks          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

PATH='/usr/bin:/bin:/usr/local/bin'
export PYTHONIOENCODING=UTF-8
echo $(date) >> /opt/plexlibrary/plexlibrary_cron.log
echo "" >> /opt/plexlibrary/plexlibrary_cron.log

for file in /opt/plexlibrary/recipes/*
do
    if [ ! -d "${file}" ]; then
        /usr/bin/python /opt/plexlibrary/plexlibrary/plexlibrary.py $(basename "$file" .yml) >> /opt/plexlibrary/plexlibrary_cron.log
        echo "" >> /opt/plexlibrary/plexlibrary_cron.log
    fi
done
