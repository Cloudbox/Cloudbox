<!---

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

Changelog Format:

## [Unreleased]

## [X.X.X] - YYYY-MM-DD

### Added
- entry.

### Changed
- entry.

### Removed
- entry.

### Fixed
- entry.


[X.X.X]: https://github.com/cloudbox/cloudbox/compare/vX.X.X-1...vX.X.X
-->

# Changelog
## [Unreleased]

## [1.2.9] - 2018-09-26

### Changed
- Backup: Added more safeguards for when a service file is disabled.
- Backup: Removed traktarr.service checks.
- Backup: Simplified Docker related messages.
- Docker: Added safeguard for when a service file is disabled.
- Plexdrive: Added safeguard for when service file is disabled.
- UnionFS: Added safeguard for when service file is disabled.
- URL: Updated url to https://cloudbox.works.

## [1.2.8] - 2018-09-11

### Added
- Submodule: ansible-ghetto-json

### Changed
- AppVeyor: Updated dependencies installer url.
- AppVeyor: Added submodule update command.
- Backup: Adds `/opt/plex/.../cache/transcode` path into backup excludes.
- Backup: Adds 'set-backup' tag to toggle cron task.
- Backup: Removed dates from log file names.
- Backup: Sets cron task under user's crontab (vs root).
- Backup: Now creates a tar for each folder in '/opt' vs just one 'cloudbox.tar' file.
- Backup: Will shut down traktarr during backups.
- Backup: Logs now go to `~/logs` vs `~/logs/backup/`.
- Cloudplow: Set default config to skip symlinks during upload.
- Nginx: Added support for customizable subdomain option via 'adv_settings.yml'.
- Organizr: direct_domain=yes will not create/use organizr subdomain.
- Permissions: Moved permissions fix to restore.
- Pre-Install: Converts all integer passwords to string.
- Pre-Tasks: Added conditional to prevent errors when old or new downloads settings are missing in 'settings.yml'.
- Python-PlexLibrary: Script will now output log to display as well.
- Restore: Will import rclone role when an rclone.conf exists in playbook dir.
- Restore: Added support for restoring multiple tar files.
- Rclone: Backup previous rclone.conf when moving one from playbook dir.
- Rclone: Cleans up legacy rclone install.
- Rclone: Installs 'man-db'.
- ruTorrent: Moved location of watched folder setting in .rc file.
- SanityCheck: Will not check for tags when running community/cloudbox_mod.
- Settings: Put all `*.defaults` into `defaults/` folder.
- Suitarr: Added umask 002 permissions.

## [1.2.7] - 2018-08-21

### Changed
- Plex Autoscan URL Script: Tweaked grep command.

### Fixed
- Rutorrent: Added missing auth info to nginx.conf.

## [1.2.6] - 2018-08-19

### Fixed
- NZBHydra2: Sets base to null value (new installs only).
- Plex Autoscan URL Script: Allows script to be run from any location.

## [1.2.5] - 2018-08-19

### Changed
- Rutorrent: Settings updated to match latest rtorrent release.

## [1.2.4] - 2018-08-18

### Added
- Backup: Added accounts.yml to backed up files list.
- Nginx
  - Can be used to host websites.
  - Access via www.domain.com or domain.com.
- OrganizrV1
  - use `--tags organizrv1`.
  - subdomain: organizrv1
  - direct_domain settings do get applied to this as well. So if you want
  to have both versions, turn the setting off before installing the other.
- Plex Auth Token role.
  - Used to generate plex auth tokens.
  - Requires Plex login info in settings.
  - Can use '--tags plex_auth_token' to display the token.
- SABnzbd
  - Install tag: --tags sabnzbd
  - Role fails when new download path settings are not set.
  - Presets login based on user/passwd from accounts.yml
  - After setup wizard finishes, it will try to redirect to domain:8080. Just take out the :8080 part and it will be OK from then on.
  - User will also need to add in categories for sonarr, radarr, and lidarr. Was also not able to do that without server already filled in.
  - Direct unpack is disabled by default. Left it as-is for user to setup basics.
  - Probably wont be seeing any documentation on the wiki for this anytime soon.
- Settings: Addition of accounts.yml.
  - Shifting of account related settings from settings.yml into accounts.yml.
- Subliminal
- Wiki: For a primer on Ansible Vaulting, and instructions on how to encrypt the accounts.yml, take a look at the newly created [Ansible Vault Primer](https://github.com/Cloudbox/Cloudbox/wiki/Ansible-Vault-Primer) wiki page.

### Changed
- Ansible: Added hash behavior merge
- Ansible: Skip installing certain apps if downloads paths are left blank (on purpose).
- Backup: Added backup_excludes.txt into role.
  - If you want to customize your own excludes list, simply drop a 'backup_excludes.txt' file in the cloudbox folder, and backup will use that one instead.
- Backup: Added ANSIBLE_CONFIG env variable to cron task.
- Backup: Added '--skip-tags settings' to the cron task.
- Backup: Moved ~/logs/ to ~/logs/backup/
- Backup: Will now stop/start Cloudbox-managed docker containers.
- Cloudplow: Pre-filled Plex token when Plex login is set.
- Common: Adds multiverse APT repositories.
- Common: Added 'common' tag to role.
- Common: Installs 'httpie'.
- Common: Installs apprise.
- Common: Installs zip.
- Common: Will only reset /opt permissions if folder age >= 7 days.
- Common: Install lxml for Ansible's XML module.
- Docker: Installs docker-ce 18.05.0 for all Ubuntu versions.
- Docker: Replaced the pip module `docker-py` with `docker`.
- Docker: Changed docker start up delay to 30s post unionfs (from 120s). 120s delay was just not needed.
- Docker: Service is always stopped/started during the role runtime.
- Docker: Added 'Purge Networks' command.
- Docker: Reworked cloudbox docker network
- Emby: Presets baseline settings
- Ctop: Added explicit download URL as failsafe.
- Gitignore: Added rclone.conf so having it in cloudbox folder doesnt git conflict.
- Hostess: Added explicit download URL as failsafe.
- Kernel: Will quit now if kernel is already updated.
- Lidarr: Now part of default install types.
- Lidarr: Support for the new downloads path settings.
- Netdata: Added HTTP auth.
- Nginx-Proxy: Create vhost.d folder.
- NZBGet: Support for the new downloads path settings.
- NZBGet: Set scripts path to /scripts/nzbget
- NZBGet: Prefetch some commonly used scripts.
- Ombi: Replaces Plex Requests for default installs.
- Organizr: Updated to v2 (beta)
  - Will migrate over folder of previous version to /opt/organizrv1.
- Organizr: Plex theme available.
- Plex: Reorganized Host Tasks (thanks _[EnorMOZ](https://github.com/EnorMOZ)_).
- Plex: Added support for entering in login info in accounts.yml
  - This will bypass the claim code prompt and automate everything needed to setup Plex.
  - Based on the work by [EnorMOZ](https://github.com/EnorMOZ).
- Plex: Added 'Forced Automatic Quality Settings' (experimental)
- Plex: adv_settings option to open/close port 32400 on host.
- Plex: Create some folders ahead of time. Prevents container from creating them in root.
- Plex: Mounted /scripts to plex.
- Plex Autoscan: Pre-filled Plex token when Plex login is set.
- Plex Autoscan: Added Music section into PLEX_SECTION_PATH_MAPPINGS for default config.
- Plex Autoscan URL Script: Support for [un]vaulted accounts.yml.
- Plex Dupefinder: Renamed sample config's TV library name as "TV Shows" to match Plex's default one.
- Plex Dupefinder: Pre-filled Plex token when Plex login is set.
- Plex Patrol: Pre-filled Plex token when Plex login is set.
- PlexLibrary: Renamed to Python-PlexLibrary to match GitHub repo name.
- Pre-Install: Cleaned up role a bit. Created variable "cloudflare_enabled".
- Pre-Install: Migrates folder to home location.
- Pre-Tasks: Created universally accessible uid, guid, and vgid variables.
- Pre-Tasks: Created variables for downloads path settings.
- Pushover: Added support for message priority.
- Radarr: Support for the new downloads path settings.
- Radarr4K: Support for the new downloads path settings.
- Rclone: Added in failsafes for incorrect version numbers etc. Will revert to 'latest' version if no setting is specified.
- Rclone: Now supports 'beta' tag as well.
- Restore: Local Mode. Rclone improvements.
- ruTorrent: Reorganized role.
- ruTorrent: Support for the new downloads path settings.
- Pushover: Now in accounts.yml. Still backwards compatible with old location under backup.
- Sanity Check: Deletes stale backup.lock files, automatically.
- Sonarr: Support for the new downloads path settings.
- Sonarr4K: Support for the new downloads path settings.
- Scripts: Updated paths for nzb and torrent scripts.
- Scripts: Changed 'nzbs' folder to 'nzbget'.
- Scripts: Added scripts folder for 'sabnzbd'.
- Scripts: Renamed nginx scripts folder to nginx-proxy.
- Settings: Adds in hash_behavior into ansible.cfg if missing.
- Settings: New downloads folder structure.
  - This will allow for more downloaders to be added without the need to modify PVR (eg Sonarr) mounts.
  - Left backwards compatibility for previous downloads folder
  settings (for now). Will eventually remove them from settings.yml.
- Shell Role: Replaces ZSH and Bash roles. Use adv_settings.yml to switch between them.
- Shell: Copy .bashrc from /etc/skel when missing.
- Telly: Updated to reflect recent changes.
- Traktarr: Automatically add in Sonarr and Radarr API keys into config.
- WebTools: Added explicit download URL as failsafe.
- WebTools: Display version installed.
- Webtools: Added tag 'reinstall-webtools'

### Fixed
- Traktarr: Fixed json errors in sample config file.
- System: Fix for certain kernel versions with no matching linux-tools.

## [1.2.3] - 2018-07-09

### **Notes**
- Requires **Ansible 2.5.1**.

### Added
- Bash Role.
- [Plex Library](https://github.com/adamgot/python-plexlibrary) Role.
- Scripts: Plex Trash Fixer.
- Tags: Added system and docker tags.

### Changed
- Ansible: Renamed ansible.cfg to ansible.cfg.default and added ansible.cfg to git ignore. This will allow for customizations by users, without causing git conflicts.
- Ansible: Turned off retry files.
- Appveyor: Tweaks.
- Backup: Excludes reflect new Sonarr/Radarr Mediacover paths.
- Backup: Minor tweaks to Docker start / stop tasks.
- Cloudplow: Added --loglevel=INFO to service file.
- Cloudplow: Added Rclone throttle speeds settings into default config.
- Credits: Reworked.
- Docker: Will stop and start running containers on task run.
- NodeJS: Separated into its own role.
- NodeJS: Will now output NodeJS, npm, and frontail versions once installed.
- NZBGet: Updated settings subtasks to match new Suitarr config location.
- NZBHydra2: Updated settings subtasks to match new Suitarr config location.
- Plex Autoscan: Added --loglevel=INFO to service file.
- Preinstall: Removed redundant tasks.
- Rclone: Will attempt to look for missing rclone.conf, and if found, move it to the default location.
- Readme: Misc tweaks.
- Restore: Tweaked existing task of moving rclone.conf file from cloudbox folder to default location (e.g. during restore). Added this to Rclone role instead.
- Settings: Added ability to rename ansible.cfg.default to ansible.cfg, if required.
- Settings: Refactoring/cleaning up of role.
- Settings: Set script task to ignore errors on fail.
- Shell: Add nano as default editor.
- Suitarr: Updated migration helper tasks to reflect recent changes.
- Traktarr: Updated default config.

### Removed

### Fixed
- NZBHydra2: Fix for incorrect image being stopped/started.
- Z: Sets correct permissions during repo clone.
- ZSH: Sets correct permissions during repo clone.


## [1.2.2] - 2018-06-25

### **Notes**
- Requires **Ansible 2.5.1**.

### Added
- [Bazarr](https://github.com/morpheus65535/bazarr) ([setup instructions](https://github.com/Cloudbox/Cloudbox/commit/bac132438267c36a5ea86c09e6a20f0c63273e55))
- Sonarr4k

### Changed
- [Suitarr](https://gitlab.com/hotio/suitarr/): Updated Docker images to new format.

## [1.2.1] - 2018-06-24

### **Notes**
- Requires **Ansible 2.5.1**.

### Added
- Adv Settings: shell option.
- Cloudplow: Adds \*\*.fuse_hidden\*\* to rclone excludes.
- Cloudplow: Adds Plex integration into default config.
- [NowShowing](https://github.com/ninthwalker/NowShowing)
- Organizr: Adds www subdomain to Organizr when direct_domain is set in adv_settings.
- Tags: shell
- Torrent Cleaner: Experimental support for Lidarr.
- [Z jump](https://github.com/rupa/z)

### Changed
- Heimdall: Creates htpasswd by default.
- NZBGet: Tweaked /scripts mount path.
- NZBHydra2: Increase JVM memory to 512MB when system has 8GB of RAM or more.
- Plex Autoscan: Updated config to support latest changes.
- Plexpy: /scripts/plexpy/ points to /opt/scripts/plexpy/.
- PreInstall: Set ownership of entire /home/user folder to user.
- ruTorrent: Tweaked /scripts mount path.
- System: Only updates ext4 mount.
- ZSH: Now installed by default, unless otherwise specified in adv_settings. Use shell tag to switch between zsh and bash.

### Removed
- Tags: zsh

### Fixed
- Nginx: Allows EPGs with large channel data to be added in to Plex. (_[EnorMOZ](https://github.com/EnorMOZ)_)
- NZBGet: Fixes missing env's for new installs.


## [1.2.0] - 2018-06-17

### **Notes**
- Requires **Ansible 2.5.1**.

### Added
- Advanced Settings: For misc/advanced settings that that don't seem to fit in main settings.yml.
- Feeder Dismount Role - Reverts all changes from Feeder Mount role.
- Feeder Mount Role - Mounts rclone feeder remote onto the /mnt/feeder path of a Plexbox.
- Ombi: Custom subdomain option in adv_settings.yml.
- Organizr: Direct domain option in adv_settings.yml.
- Plex Requests: Custom subdomain option in adv_settings.yml.
- System: Removes useless packages and dependencies.
- Ubuntu: Support for 18.04. (_[EnorMOZ](https://github.com/EnorMOZ)_)
- [Cloudplow](https://github.com/l3uddz/cloudplow/) - Replaces UnionFS Cleaner.
- [Nethogs](https://github.com/raboof/nethogs) (_[EnorMOZ](https://github.com/EnorMOZ)_)
- [Telly](https://github.com/tombowditch/telly) - Options are set in adv_settings.yml. (_[EnorMOZ](https://github.com/EnorMOZ)_)
- [iperf3](https://software.es.net/iperf/)

### Changed
- Backup: Excludes /opt/sonarr/MediaCover and /opt/radarr/MediaCover.
- Backup: Misc tweaks to prevent issues.
- Backup: Move previous backup files to archived folder.
- Backup: Send pushover message when backup terminates due to an error.
- Cloudflare: CB related subdomains are now: cloudbox, mediabox, feederbox. Don't put these behind proxy/CDN, as these are meant to reach your server directly.
- NZBGet: Removed /opt/nzbget/scripts path. Use /opt/scripts/nzb/ instead.
- NZBHydra1: Switched to LSIO image as Hotio/Suitarr dropped support.
- NZBHydra1: Config files for Suitarr path now automatically migrated over to LSIO path.
- NZBHydra1 is now an optional addon.
- NZBHydra2: Automates entering in login and auth info, and sets JVM memory to 512MB if the system has >= 16GB of RAM.
- NZBHydra2: Mounts NZBHydra1, so that previous config/db can be migrated on first install or from settings later. See https://i.imgur.com/CneRSWw.png for the paths needed.
- NZBHydra2: NZBHydra2 now replaces NZBHydra1 for "default" installs (i.e. cloudbox, feederbox).
- PIP: Suppress outdated pip warnings.
- Plex Autoscan: Added music folder into default config.
- Plex Autoscan: URL Script will catch errors and display message (e.g. missing dependencies, invalid JSON formatting). Added some visual enhancements.
- Pre-Tasks: Removes cloudbox subdomain for plex/feeder box installs.
- Readme: Cleaner look.
- Rutorrent: Disables extsearch plugin for new installs. Will help fix some slow loading issues.
- Rutorrent: Uses same password as passwd in settings.yml
- Sanity Check: Exit any CB install when backup is in progress.
- Sanity Check: Make sure users are using a valid tag. (_[EnorMOZ](https://github.com/EnorMOZ)_)
- Settings: Took out entry for Plex Autoscan IP, as it's usually 0.0.0.0 for CB purposes.
- Suitarr: Updated tasks to reflect new config paths.
- Tags: Added new tag core
- Tags: full -> cloudbox
- Tags: plex -> mediabox
- Tags: feeder -> feederbox
- Tags: update- and install- prefixes removed from all tags (i.e. the tags are still there but without update- or install- in front of it)
- Tags: To see a full list of tags: sudo ansible-playbook cloudbox.yml --list-tags

### Removed
- UnionFS Cleaner

### Fixed
- Ansible: Added localhost to inventory to suppress warning messages.
- Cron: Added PATH to fix issues with backup and purge-old-kernels.
- NZBGet: Fixed unrar issue with latest version of NZBGet. (_[RXWatcher](https://github.com/RXWatcher1)_)
- Rclone: Fixed permission issues with ~/.config paths.



## [1.1.3] - 2018-05-21

### **Notes**
This version requires **Ansible 2.5.1** (2.3.1.0 will give  syntax errors; 2.5.0 has a bug with a certain math function that backup uses; 2.5.2-2.5.3 will complain when both docker-py and docker are installed).

To install Ansible 2.5.1:
```bash
curl -s https://cloudbox.rocks/install_dependencies.sh | sudo -H sh -s 2.5.1
```
  or
```bash
wget -qO- https://cloudbox.rocks/install_dependencies.sh | sudo -H sh -s 2.5.1
```

To checkout this version of Cloudbox:
```
cd ~/cloudbox
git reset --hard COMMITID
```

You can also download the source zip file and extract it into the cloudbox folder.

### Added

### Changed
- AppVeyor: Will now install the default Ansible version in the Dependencies Installer Script.
- Common: Install/Update to latest ctop version.
- Common: Install/Update to latest hostess version.
- Plex: Will auto-update to the latest WebTools version.
- Webtools: Moved into a separate role.

### Removed

### Fixed
- Cloudflare: Task name shows correct IP address, now.
- Docker: Added docker-py back; set installed Ansible ver to 2.5.2 until issues with 2.5.3 are fixed.

## [1.1.2] - 2018-05-19

### **Notes**
Use v1.1.3 or v1.1.1, instead.

### Added

### Changed
- AppVeyor: Set build to Ansible version 2.5.3.
- Cloudbox: Added headers to all roles and scripts.

### Removed
- Docker: Removed docker-py. Ansible finds a conflict with both docker-py and docker installed.

### Fixed
- Ansible: Fixed misc warning messages.

## [1.1.1] - 2018-05-19

### **Notes**
This version, and the versions below, are compatible with **Ansible 2.3.1.0**,  and possibly up to 2.4.0.

To install Ansible 2.3.1.0:
```bash
curl -s https://cloudbox.rocks/install_dependencies.sh | sudo -H sh -s 2.3.1
```
  or
```bash
wget -qO- https://cloudbox.rocks/install_dependencies.sh | sudo -H sh -s 2.3.1
```

To checkout this version of Cloudbox:
```
cd ~/cloudbox
git reset --hard 58964a8
```

### Added
- [Plex Patrol](https://github.com/l3uddz/plex_patrol).
- [Cloudbox MOTD](https://github.com/cloudbox/cloudbox_motd): Cloudbox-enhanced MOTD.
- AppVeyor CI

### Changed
- Backup: Exclude Plex cache folder in backup.
- Backup: Logs are created in ~/logs/ path.
- Backup: Misc edits for cron task.
- Common: Installs unrar-free if unrar could not be installed.
- Common: Netaddr is now installed via the Dependency Installer script.
- Common: Set /opt to ugo+X instead of 775.
- Docker: Better log size management.
- Docker: Updated to 18.03.1.
- Kernel: Now runs without settings-updater checks.
- Nginx-Proxy: Renamed update tag to update-nginx-proxy vs update-nginx.
- Node.js: Updated to v10.X.
- Plex Autoscan: Fixed up Plex Autoscan URL Script.
- Plex Dupefinder: misc changes to default config.
- PlexPy (Tautulli): Now downloads nightly version.
- Readme: Added feathub link.
- Rutorrent: Added stop_timeout to Docker container.
- Traktarr: misc changes to default config.
- Watchower: now an optional module.

### Removed
- MOTD: previous version.

### Fixed
- Backup: systemd-backup now uses synchronize, should avoid issues with copy module failing on 0 byte files.
- Cloudflare: Now only creates a single subdomain entry.
- Cloudflare: Public IP Address will now be used.
- Preinstall: No longer changes the user's shell on Cloudbox run (eg full).
- ZSH: Existing .zshrc file will no longer be replaced with default one.
- ZSH: Will now link to /bin/zsh if it doesn't already do so.


## [1.1.0] - 2018-04-18
### Added
- `.gitignore`
  - `git pull` will no longer have conflicts with logs, retry files, etc.
- `CREDITS.md`
- `CONTRIBUTING.md`
  - guide on how to submit Pull Requests (to develop branch).
- `Zsh` role
  - Will install Zsh & [Oh My Zsh](http://ohmyz.sh), and set Zsh as the default shell (this role does not run by default).
  - install: `--tags install-zsh`
  - config: `~/.zshrc`
- Python modules
  - netaddr - for Ansible's `ipv4` filter.
  - dnspython - for Ansible's `dig` lookup.
- [Heimdall](https://heimdall.site/) (_[Captain-NaCl](https://github.com/Captain-NaCl)_)
  - subdomain: `heimdall`
  - install: `--tags install-heimdall`
  - folder: `/opt/heimdall`
- [Traktarr](https://github.com/l3uddz/traktarr)
  - install: `--tags install-traktarr`
  - folder: `/opt/traktarr`
- Settings Updater
  - GitHub repo will now only contain a `settings.yml.default` file.
  - Doing a git pull/hard reset will no longer wipe out one's `settings.yml` file.
  - Any new additions to `settings.yml.default` will be added into the `settings.yml` automatically, with the following message:
    ```
    fatal: [localhost]: FAILED! => {"changed": false, "msg": "The script 'settings_updater.py' added new settings. Check 'settings-updater.log' for details of new setting names added."}
    ```
  - User can then take a look at `settings-updater.log` file to see what was added.
  - This allows new features to be added without breaking compatibility with older versions of Cloudbox.
- [screen](https://www.gnu.org/software/screen/manual/screen.html)
- [tmux](http://man.openbsd.org/OpenBSD-current/man1/tmux.1)
- [Plex Dupefinder](https://github.com/l3uddz/plex_dupefinder/)
  - install: `--tags install-plex_dupefinder`
  - folder: `/opt/plex_dupefinder`
- [Dependency Installer Script](https://github.com/cloudbox/cloudbox/wiki/First-Time-Install%3A-Downloading-Cloudbox#1-install-dependencies)
  - Simple, clean install script.
  - Fixes potential pip issues.
- [Radarr4K](https://radarr.video)
  - Basically, just an extra copy of Radarr (to be used for any purpose, including the building of a 4K only library).
  - subdomain: `radarr4k`
  - install: `--tags install-radarr4k`
  - folder: `/opt/radarr4k/`
  - Uses port `7879`.
  - Only mounts `/mnt/`
    - User's choice on where to keep 4K movies...
    - Examples:
      -  `/mnt/unionfs/Media/Movies/Movies4K/`
      -  `/mnt/unionfs/Media/Movies4K/`
  - Plex Autoscan will also require tweaking. See "Configuring Plex Libraries" wiki page for more info.
- HTTP Authentication support
  - Uses folder path `/opt/nginx-proxy/htpasswd/.
  - Allows setting up of basic HTTP authentication for any subdomain - use this to secure Docker web apps that don't have native login support.
  - Command: `htpasswd -c /opt/nginx-proxy/htpasswd/SUBDOMAIN.DOMAIN.COM USERNAME` (replace `SUBDOMAIN`/`DOMAIN` with user's info; replace  `USERNAME` with desired HTTP auth username).
    - User will be prompted for a password.
    - Restart the relevant Docker container for it to take effect (`docker restart appname`).
    - To remove the HTTP authentication, simply remove the file from `/opt/nginx-proxy/htpasswd/` and restart the relevant Docker container.
- [Cloudflare DNS](https://www.cloudflare.com/) support
  - Added `cloudflare_api_token` to `settings.yml`.
  - When API token is filled in, Cloudbox will automatically create DNS entries (non proxied/CDN), and/or update them with the host's IP address, when relevant tasks are run.
  - Will also add one of 3 relevant subdomains: `plexbox`, `feederbox`, or `cloudbox`.
    - This is useful for ssh, ftp, etc, especially with a Feederbox/Plexbox setup.
  - This requires the email address in `settings.yml` to match the one used for the Cloudflare account.
- [The Lounge](https://thelounge.chat/)
  - subdomain: `thelounge`
  - install: `--tags install-thelounge`
  - folder: `/opt/thelounge`
- [ZNC](https://wiki.znc.in/ZNC)
  - Uses ZNC Docker image by [Horjulf](https://github.com/horjulf/docker-znc).
  - subdomain: `znc`
  - install: `--tags install-znc`
  - folder: `/opt/znc`
- [Quassel IRC core](https://quassel-irc.org/)
  - subdomain: `quassel`
  - install: `--tags install-quassel`
  - folder: `/opt/quassel`

### Changed
- `README.md`
  - Cleaned up a bit.
  - Moved chart of installed items to the Wiki (i.e. [Cloudbox Install Types](https://github.com/cloudbox/cloudbox/wiki/Basics%3A-Cloudbox-Install-Types)).
- Rclone
  - In `settings.yml`, use `latest` for rclone version to always install the latest version.
    - Version numbers can still be used (i.e `1.40`).
  - `rclone` binary location: `/usr/bin/rclone` (as https://rclone.org/install/ prefers).
  - `rclone.conf` location: `~/.config/rclone/rclone.conf`.
  - Removed the use of `/opt/rclone/` folder (and the symlinks within it).
- Backup
  - Rclone uses less bandwidth, due to server-side move commands (initially submitted by _[RXWatcher](https://github.com/RXWatcher1)_).
  - Will archive older versions of `cloudbox.tar` on Rclone remotes (initially submitted by _[RXWatcher](https://github.com/RXWatcher1)_).
  - Systemd files will be saved to `/opt/systemd-backup` (vs `/opt/systemd`). The name makes the purpose of the folder clearer.
  - Local `cloudbox.tar.backup` file is now deleted after a successful tar archiving task.
  - Will now `rclone.conf` and `settings.yml` files separate from `cloudbox.tar`. Older versions of these files will also be archived on rclone remotes.
- Restore
  - Restore looks for `rclone.conf` in `~/cloudbox/` first, and then `~/.config/rclone/`.
  - If `rclone.conf` exists in both locations, `~/cloudbox/rclone.conf` will take precedence for restore task and be be copied over `~/.config/rclone/rclone.conf` (overwriting the previous one).
- Backup/Restore: Added `keep_local_copy` option in `settings.yml`.
  - Option to keep or remove local backup (`cloudbox.tar`).
  - During backup, if `use_rclone`/`use_rsync` is `false` and `keep_local_copy` is set to `true`, then backup will be made to local file only.
  - During restore, if `keep_local_copy` is set to `true` and a local backup file (`cloudbox.tar`) exists, then that local backup file will be used for the restore task (no rclone / resync download of a remote `cloudbox.tar` file will occur).
    - This is handy for when a user just wants to drop in a backup file and restore from it.
- Plex
  - Added hosts required for [Lazyman Plex Channel](https://github.com/nomego/Lazyman.bundle).
- Service Files
  - Modified `unionfs.service` file to added 30 second wait to start to UnionFS.
    - Gives extra time for other mounts to be loaded before Unionfs starts.
    - This helps with users who 1. have more than one mounts setup (eg rclone sftp mount for a feederbox) and 2. are using encrypted rclone mounts with plexdrive (takes longer to start up).
  - Misc edits to `plex_autoscan` and `unionfs.service`.
- Docker
  - Force the installation of `docker-ce` `v17.09.0` and prevent it from being updated.
    - This is to prevent issues mentioned here: https://github.com/moby/moby/issues/35933.
  - Better log size management  (_[EnorMOZ](https://github.com/EnorMOZ)_)
- [ctop](https://ctop.sh/)
  - version updated to `0.7.1`.
- Scripts
  - Added new script: `arrpush.py` (for ruTorrent autodl-irssi)
    - COMMAND: `/scripts/arrpush.py`
    - ARGUMENTS: `"http://sonarr:8989" "API_KEY" "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
    - ARGUMENTS: `"http://radarr:7878" "API_KEY" "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
  - Renamed `arrpush.sh` (the previous script) to `arrpush.legacy.sh`.
    - COMMAND: `/scripts/arrpush.legacy.sh`
    - ARGUMENTS: `sonarr "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
    - ARGUMENTS: `radarr "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
  - Moved script folder creation tasks here.
  - Added Ansible tag: `--tags update-scripts`
  - Removed `cloudflared.py` as this is not needed anymore.
- Sanity Check
  - Will always occur no matter what Ansible task is run.
- Resilio Sync
  - Switched to official Resilio Docker image.
  - Advanced options now persist after restart.
  - Files created (still) retain correct permissions.
- Ombi
  - Switched to `linuxserver/ombi` image (as it now installs v3).
- Misc
  - Set `sudo` group to NOPASSWD (no more password prompts when running sudo commands).
  - Preinstall Role no longer changes user's shell on Cloudbox run (eg full).
- [Plex Autoscan](https://github.com/l3uddz/plex_autoscan)
  - The following variables were added to config.json:
    - `PLEX_ANALYZE_DIRECTORY`
    - `PLEX_ANALYZE_TYPE`
    - `RUN_COMMAND_BEFORE_SCAN`
    - `RCLONE_RC_CACHE_EXPIRE`
    - `SERVER_SCAN_PRIORITIES`

### Removed
- Github
  - removed `.github` folder from the repo.

### Fixed
- Ansible
  - Fixed misc SSL errors with Github links.
- MOTD
  - Now shows memory info (based off the word of _[EnorMOZ](https://github.com/EnorMOZ)_)
- rclone
  - fix for trailing zeroes in version numbers.


## [1.0.2] - 2018-2-22
### Added
- [Rclone](https://rclone.org/)
  - Added the "update-rclone" tag (`--tags update-rclone`).
- [Lidarr](http://lidarr.audio/)
  - subdomain: `lidarr`
  - install: `--tags install-lidarr`
  - folder: `/opt/lidarr`
- [Emby](https://emby.media/)
  - subdomain: `emby`
  - install: `--tags install-emby`
  - folder: `/opt/emby`
- [NZBHydra2](https://github.com/theotherp/nzbhydra)
  - subdomain: `nzbhydra2`
  - install: `--tags install-nzbhydra2`
  - folder: `/opt/nzbhydra2`

### Changed
- [ruTorrent](https://github.com/Novik/ruTorrent)
  - Now uses ruTorrent Docker image by [Horjulf](https://github.com/horjulf/docker-rutorrent-autodl).
  - subdomain: `rutorrent`
  - install: `--tags update-rutorrent`
  - folder: `/opt/rutorrent`
- [WebTools](https://github.com/ukdtom/WebTools.bundle)
  - Updated to v3.0.0 (to update, see this [FAQ](https://github.com/cloudbox/cloudbox/wiki/FAQ#update-webtools) page).
- [PlexPy](http://tautulli.com/)
  - Now installs PlexPy v2 (aka Tautulli)
  - subdomain: `plexpy`
  - install: `--tags update-plexpy`
  - folder: `/opt/plexpy`


## [1.0.1] - 2017-12-30
### Added
- Anisble
  - Ansible-Toolbox
- [Ombi](http://www.ombi.io/)
  - subdomain: `ombi`
  - install: `--tags install-ombi`
  - folder: `/opt/ombi`
- [Resilio Sync](https://www.resilio.com/)
  - To install, run the Cloudbox install command with `--tags install-resilio`.
  - subdomain: `resilio`
  - install: `--tags install-resilio`
  - folder: `/opt/resilio`
- [Glances](https://nicolargo.github.io/glances/)
  - Command line tool; simply run `glances`.
- [Nextcloud](https://nextcloud.com/)
  - To install, run the Cloudbox install command with `--tags install-nextcloud`.
  - subdomain: `nextcloud`
  - install: `--tags install-nextcloud`
  - folder: `/opt/nextcloud`

### Changed
- Arrpush
  - minor adjustments
- Docker
  - containers now use dynamic IP addresses.
  - Suitarr Docker containers now use default app ports). This effects Sonarr, Radarr, NZBGet, NZBHydra, and Jackett.

## [1.0.0] - 2017-12-01
### Initial Release



[Unreleased]: https://github.com/cloudbox/cloudbox/compare/HEAD...develop
[1.2.9]: https://github.com/cloudbox/cloudbox/compare/v1.2.8...v1.2.9
[1.2.8]: https://github.com/cloudbox/cloudbox/compare/v1.2.7...v1.2.8
[1.2.7]: https://github.com/cloudbox/cloudbox/compare/v1.2.6...v1.2.7
[1.2.6]: https://github.com/cloudbox/cloudbox/compare/v1.2.5...v1.2.6
[1.2.5]: https://github.com/cloudbox/cloudbox/compare/v1.2.4...v1.2.5
[1.2.4]: https://github.com/cloudbox/cloudbox/compare/v1.2.3...v1.2.4
[1.2.3]: https://github.com/cloudbox/cloudbox/compare/v1.2.2...v1.2.3
[1.2.2]: https://github.com/cloudbox/cloudbox/compare/v1.2.1...v1.2.2
[1.2.1]: https://github.com/cloudbox/cloudbox/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/cloudbox/cloudbox/compare/v1.1.3...v1.2.0
[1.1.3]: https://github.com/cloudbox/cloudbox/compare/v1.1.2...v1.1.3
[1.1.2]: https://github.com/cloudbox/cloudbox/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/cloudbox/cloudbox/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/cloudbox/cloudbox/compare/v1.0.2...v1.1.0
[1.0.2]: https://github.com/cloudbox/cloudbox/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/cloudbox/cloudbox/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/cloudbox/cloudbox/compare/9af69ab...v1.0.0
