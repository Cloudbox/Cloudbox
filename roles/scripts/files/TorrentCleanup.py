#!/usr/bin/env python
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
    log.error("You must specify an argument of either sonarr/radarr")
    sys.exit(0)
elif sys.argv[1].lower() == "sonarr":
    sourceFile = os.environ.get('sonarr_episodefile_sourcepath')
    sourceFolder = os.environ.get('sonarr_episodefile_sourcefolder')
elif sys.argv[1].lower() == "radarr":
    sourceFile = os.environ.get('radarr_moviefile_sourcepath')
    sourceFolder = os.environ.get('radarr_moviefile_sourcefolder')
else:
    log.error("Unable to determine cleanup requester. This must be either sonarr or radarr")
    sys.exit(0)

if os.path.exists(sourceFile) and os.path.isfile(sourceFile):
    # Scan folder for rar, if rar exists, remove sourceFile
    for found_file in os.listdir(sourceFolder):
        if found_file.endswith(".rar"):
            os.remove(sourceFile)
            log.info("Purged '%s'", sourceFile)
            break
