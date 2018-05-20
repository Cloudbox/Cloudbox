<!---

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

Changelog Format:

## [Unreleased]

## [X.X.X] - YEAR-MM-DD

### Added
- entry.

### Changed
- entry.

### Removed
- entry.

### Fixed
- entry.


[X.X.X]: https://github.com/Cloudbox/Cloudbox/compare/vX.X.X-1...vX.X.X
-->

# Changelog
## [Unreleased]

## [1.1.2] - 2018-05-19
### Added

### Changed
- AppVeyor: Set build to Ansible version 2.5.3.
- Cloudbox: Added headers to all roles and scripts.

### Removed
- docker-py: Ansible finds a conflict with having both docker-py and docker.

### Fixed
- Ansible: Fixed misc warning messages.

## [1.1.1] - 2018-05-19
### Added
- [Plex Patrol](https://github.com/l3uddz/plex_patrol).
- [Cloudbox MOTD](https://github.com/Cloudbox/cloudbox_motd): Cloudbox-enhanced MOTD.
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
- [Heimdall](https://heimdall.site/) (submitted by _Captain-NaCl_)
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
- [Dependency Installer Script](https://github.com/Cloudbox/Cloudbox/wiki/First-Time-Install%3A-Downloading-Cloudbox#1-install-dependencies)
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
  - Moved chart of installed items to the Wiki (i.e. [Cloudbox Install Types](https://github.com/Cloudbox/Cloudbox/wiki/Basics%3A-Cloudbox-Install-Types)).
- Rclone
  - In `settings.yml`, use `latest` for rclone version to always install the latest version.
    - Version numbers can still be used (i.e `1.40`).
  - `rclone` binary location: `/usr/bin/rclone` (as https://rclone.org/install/ prefers).
  - `rclone.conf` location: `~/.config/rclone/rclone.conf`.
  - Removed the use of `/opt/rclone/` folder (and the symlinks within it).
- Backup
  - Rclone uses less bandwidth, due to server-side move commands (initially submitted by _RXWatcher1_).
  - Will archive older versions of `cloudbox.tar` on Rclone remotes (initially submitted by _RXWatcher1_).
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
  - Better log size management  (_EnorMOZ_)
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
  - Now shows memory info (based off the word of _EnorMOZ_)
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
  - Updated to v3.0.0 (to update, see this [FAQ](https://github.com/Cloudbox/Cloudbox/wiki/FAQ#update-webtools) page).
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



[Unreleased]: https://github.com/Cloudbox/Cloudbox/compare/HEAD...develop
[1.1.2]: https://github.com/Cloudbox/Cloudbox/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/Cloudbox/Cloudbox/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.2...v1.1.0
[1.0.2]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/Cloudbox/Cloudbox/compare/9af69ab...v1.0.0
