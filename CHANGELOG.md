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


## [1.02] - 2018-2-22
### Added
- [Rclone](https://rclone.org/): Added the "update-rclone" tag (`--tags update-rclone`).
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
- [ruTorrent](https://github.com/horjulf/docker-rutorrent-autodl): Now uses Horjulf's Docker image.
  * subdomain: `rutorrent`
  - install: `--tags update-rutorrent`
  - folder: `/opt/rutorrent`
- [WebTools](https://github.com/ukdtom/WebTools.bundle): Updated to v3.0.0 (to update read [this](https://github.com/Cloudbox/Cloudbox/wiki/FAQ#update-webtools))
- [PlexPy](http://tautulli.com/): Now installs PlexPy v2 (aka Tautulli)
  - subdomain: `plexpy`
  - install: `--tags update-plexpy`
  - folder: `/opt/plexpy`
- Backup Tasks (thanks RXWatcher1)
  - Rclone tasks uses up less bandwith.
  - Will archive older versions on Rclone remotes. 

## [1.0.1] - 2017-12-30
### Added
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
  * Command line: `glances`
- [Nextcloud](https://nextcloud.com/)
  - To install, run the Cloudbox install command with `--tags install-nextcloud`.
  - subdomain: `nextcloud`
  - install: `--tags install-nextcloud`
  - folder: `/opt/nextcloud`

### Changed
- Arrpush adjustments.
- Docker containers now use dynamic IP addresses.
- Now use default app ports for Suitarr docker image containers.

## [1.0.0] - 2017-12-01
### Initial Release



[Unreleased]: https://github.com/Cloudbox/Cloudbox/compare/HEAD...develop
[1.0.2]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/Cloudbox/Cloudbox/compare/9af69ab...v1.0.0
