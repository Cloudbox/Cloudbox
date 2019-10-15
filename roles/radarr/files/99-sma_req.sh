#!/usr/bin/with-contenv bash

if [[ ! -f /sma_req_installed ]]; then
    apt update
    apt install -y --no-install-recommends --no-install-suggests python-pip python-setuptools ffmpeg
    pip --no-cache-dir install requests requests[security] requests-cache babelfish stevedore==1.19.1 python-dateutil deluge-client qtfaststart "guessit<2" "subliminal<2"
    touch /sma_req_installed
fi
