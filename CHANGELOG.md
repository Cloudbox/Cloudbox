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
### Added
- `.gitignore`
  * so that `git pull` has less conflicts with logs and other misc files.
- `CREDITS.md`
- `CONTRIBUTING.md`
  * guide on how to submit Pull Requests (to develop branch).
- `Zsh` role
  * Will install Zsh & [Oh My Zsh](http://ohmyz.sh), and set Zsh as the default shell (this role is not run by by default).
  * To install: Run CB with `--tags install-zsh`
- Python modules
  * netaddr - for Ansible's `ipv4` filter.
  * dnspython - for Ansible's `dig` lookup.


### Changed
- `README.md`
  * cleaned up a bit.
  * Moved chart of installed items to the Wiki (i.e. [Cloudbox Install Types](https://github.com/Cloudbox/Cloudbox/wiki/Basics%3A-Cloudbox-Install-Types)).
- Rclone
   - Use `latest` (in `settings.yml`) to always install the newest version.
   - `rclone` binary location: `/usr/bin/rclone` (as https://rclone.org/install/ prefers).
   - `rclone.conf` location: `~/.config/rclone/rclone.conf`.
   - Removed the use of `/opt/rclone/` folder (and the symlinks within it).
* Backup
  - Rclone uses less bandwidth, due to server-side move commands (_RXWatcher1_).
  - Will archive older versions of `cloudbox.tar` on Rclone remotes (_RXWatcher1_).
  - Systemd files will be saved to `/opt/systemd-backup` (vs `/opt/systemd`). The name makes the purpose of the folder clearer.
  - `cloudbox.tar.backup` is now deleted after a successful tar task.
   - Added `keep_local_copy` option in `settings.yml`.
      - Option to keep or remove local `cloudbox.tar`.
      - During backup, if use_rclone/rsync is `false` and `keep_local_copy` is set to `true`, then backup will still continue, but will be made to local file only.
      - During restore, if `keep_local_copy` is set to `true` and a local `cloudbox.tar` exists, then that will be preferred over an rclone/rsync copy (i.e. no rclone/rsync task will run/need to run).
         - This is handy for when you just want to drop in a backup file and restore from it.
   - Backup of `rclone.conf` and `settings.yml` separate from `cloudbox.tar` file. Older versions of these files will also be archived on rclone remotes.
- Restore
  - Restore looks for `rclone.conf` in `~/cloudbox/` and `~/.config/rclone/`.
  - If `rclone.conf` exists in both locations, `~/cloudbox/rclone.conf` will take precedence for restore task and be be copied over `~/.config/rclone/rclone.conf` (overwriting the previous one).
 - Plex
   - Added hosts required for [Lazyman Plex Channel](https://github.com/nomego/Lazyman.bundle) (i.e `mf.svc.nhl.com` and `mlb-ws-mf.media.mlb.com`).
 - Service Files
   - Modified `unionfs.service` file to added 30 second wait to start to UnionFS.
     - Gives extra time for other mounts to be loaded before Unionfs starts.
     - This helps with users who 1. have more than one mounts setup (eg rclone sftp mount for a feederbox) and 2. are using encrypted rclone mounts with plexdrive (takes longer to start up).
   - Other misc edits to `plex_autoscan` and `unionfs.service`.
 - Docker
   - Force the installation of `docker-ce v17.09.0`.
     - Should prevent issues mentioned here: https://github.com/moby/moby/issues/35933.
     - Will update to a newer version once the issue mentioned above is resolved.
   - Prevent `docker-ce` from being upgraded.
 - ctop
   - version updated to `0.7`.
 - Scripts:
    - Added new script: `arrpush.py` (for ruTorrent autodl-irssi)
      - COMMAND: `/scripts/arrpush.py`
      - ARGUMENTS: `"http://sonarr:8989" "API_KEY" "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
      - ARGUMENTS: `"http://radarr:7878" "API_KEY" "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
    - Renamed `arrpush.sh` (the previous script) to `arrpush.legacy.sh`.
      - COMMAND: `/scripts/arrpush.legacy.sh`
      - ARGUMENTS: `sonarr "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
      - ARGUMENTS: `radarr "$(TorrentName)" "$(TorrentUrl)" "$(TorrentSize)" "$(Tracker)"`
    - Simplified code.

### Removed
- Github
  - removed `.github` folder from the repo.

### Fixed
- Ansible
  - Fixed misc SSL errors with Github links.


## [1.0.2] - 2018-2-22
### Added
- [Rclone](https://rclone.org/)
  * Added the "update-rclone" tag (`--tags update-rclone`).
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
- [ruTorrent](https://github.com/horjulf/docker-rutorrent-autodl)
  - Now uses Horjulf's Docker image.
  - subdomain: `rutorrent`
  - install: `--tags update-rutorrent`
  - folder: `/opt/rutorrent`
- [WebTools](https://github.com/ukdtom/WebTools.bundle)
  * Updated to v3.0.0 (to update, see this [FAQ](https://github.com/Cloudbox/Cloudbox/wiki/FAQ#update-webtools) page).
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
  * Command line tool; simply run `glances`.
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
  * Suitarr docker containers now use default app ports). This effects Sonarr, Radarr, NZBGet, NZBHydra, and Jackett.

## [1.0.0] - 2017-12-01
### Initial Release



[Unreleased]: https://github.com/Cloudbox/Cloudbox/compare/HEAD...develop
[1.0.2]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/Cloudbox/Cloudbox/compare/9af69ab...v1.0.0
