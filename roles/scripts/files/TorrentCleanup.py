#!/usr/bin/env python
"""

    #########################################################################
    # Title:         Torrent Cleanup Script                                 #
    # Author(s):     L3uddz                                                 #
    # URL:           https://github.com/cloudbox/cloudbox                   #
    # Description:   Cleanup auto extracted files in ruTorrent downloads.   #
    # --                                                                    #
    #         Part of the Cloudbox project: https://cloudbox.works          #
    #########################################################################
    #                   GNU General Public License v3.0                     #
    #########################################################################

    Sonarr Setup:
    -------------
    1. Click "Settings" -> "Connect".

    2. Add a new "Custom Script".

    3. Add the following:

        i. Name: Torrent Cleanup

        ii. On Grab: No

        iii. On Download: Yes

        iv. On Upgrade: Yes

        v. On Rename: No

        vi. Path: /scripts/torrents/TorrentCleanup.py

        vii. Arguments: sonarr

    ========================================================================

    Radarr Setup:
    -------------
    1. Click "Settings" -> "Connect".

    2. Add a new "Custom Script".

    3. Add the following:

        i. Name: Torrent Cleanup

        ii. On Grab: No

        iii. On Download: Yes

        iv. On Upgrade: Yes

        v. On Rename: No

        vi. Path: /scripts/torrents/TorrentCleanup.py

        vii. Arguments: radarr

    ========================================================================

    Lidarr Setup:
    -------------
    1. Click "Settings" -> "Connect".

    2. Add a new "Custom Script".

    3. Add the following:

        i. Name: Torrent Cleanup

        ii. On Grab: No

        iii. On Album Import: Yes

        iv. On Track Import: Yes

        v. On Track Upgrade: Yes

        vi. On Rename: No

        vii. Path: /scripts/torrents/TorrentCleanup.py

        viii. Arguments: lidarr

    ========================================================================

"""
import logging
import os
import sys

# Setup logger
log_filename = os.path.join(os.path.dirname(sys.argv[0]), 'cleanup.log')
logging.basicConfig(
    filename=log_filename,
    level=logging.INFO,
    format='[%(asctime)s] %(levelname)s - %(message)s'
)
log = logging.getLogger("TorrentCleanup")

# Retrieve Required Variables
if len(sys.argv) <= 1:
    log.error("You must specify an argument of either sonarr/radarr/lidarr.")
    sys.exit(0)
elif sys.argv[1].lower() == "sonarr":
    sourceFile = os.environ.get('sonarr_episodefile_sourcepath')
    sourceFolder = os.environ.get('sonarr_episodefile_sourcefolder')
elif sys.argv[1].lower() == "radarr":
    sourceFile = os.environ.get('radarr_moviefile_sourcepath')
    sourceFolder = os.environ.get('radarr_moviefile_sourcefolder')
elif sys.argv[1].lower() == "lidarr":
    sourceFile = os.environ.get('lidarr_trackfile_sourcepath')
    sourceFolder = os.environ.get('lidarr_trackfile_sourcefolder')
else:
    log.error("Unable to determine cleanup requester. This must be either sonarr, radarr, or lidarr.")
    sys.exit(0)

if os.path.exists(sourceFile) and os.path.isfile(sourceFile):
    # Scan folder for rar, if rar exists, remove sourceFile
    for found_file in os.listdir(sourceFolder):
        if found_file.endswith(".rar"):
            os.remove(sourceFile)
            log.info("Purged '%s'", sourceFile)
            break
