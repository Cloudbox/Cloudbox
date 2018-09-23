#!/bin/bash
#########################################################################
# Title:         Cloudbox: Python-PlexLibrary Helper Script             #
# Author(s):     Desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

PATH='/usr/bin:/bin:/usr/local/bin'
export PYTHONIOENCODING=UTF-8
echo $(date) | tee -a /opt/python-plexlibrary/plexlibrary.log
echo "" | tee -a /opt/python-plexlibrary/plexlibrary.log

for file in /opt/python-plexlibrary/recipes/*
do
    if [ ! -d "${file}" ]; then
        /usr/bin/python /opt/python-plexlibrary/plexlibrary/plexlibrary.py $(basename "$file" .yml) | tee -a /opt/python-plexlibrary/plexlibrary.log
        echo "" | tee -a /opt/python-plexlibrary/plexlibrary.log
    fi
done
