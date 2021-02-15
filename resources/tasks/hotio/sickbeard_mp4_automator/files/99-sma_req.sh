#!/usr/bin/with-contenv bash

#########################################################################
# Title:         Cloudbox: SMA Requirements Installer Script            #
# Author(s):     desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

if [[ ! -f /sma_req_installed ]]; then
    apt update
    apt install -y --no-install-recommends --no-install-suggests \
        python3-pip \
        python3-setuptools \
        ffmpeg
    pip3 --no-cache-dir install \
        requests \
        requests[security] \
        requests-cache \
        babelfish \
        tmdbsimple \
        mutagen \
        guessit \
        stevedore \
        python-dateutil \
        deluge-client \
        qtfaststart \
        pymediainfo \
        python-qbittorrent \
        gevent \
        subliminal
    touch /sma_req_installed
fi
