<!---

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

Changelog Format:

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
- Rclone: update tag (`--tags update-rclone`).
- [Lidarr](http://lidarr.audio/)
  - To install, run the Cloudbox install command with `--tags install-lidarr`.
- [Emby](https://emby.media/)
  - To install, run the Cloudbox install command with `--tags install-emby`.

### Changed
- ruTorrent: Now uses [horjulf/rutorrent-autodl](https://github.com/horjulf/docker-rutorrent-autodl) Docker image.
- WebTools: Updated to v3.0.0

## [1.0.1] - 2017-12-30
### Added
- Ansible-Toolbox
- [Ombi](http://www.ombi.io/)
  - To install, run the Cloudbox install command with `--tags install-ombi`.
- [Resilio Sync](https://www.resilio.com/)
  - To install, run the Cloudbox install command with `--tags install-resilio`.
- [Glances](https://nicolargo.github.io/glances/)
- [Nextcloud](https://nextcloud.com/)
  - To install, run the Cloudbox install command with `--tags install-nextcloud`.

### Changed
- Arrpush adjustments.
- Docker containers now use dynamic IP addresses.
- Use default app ports for Suitarr containers due to Docker image changes.

## [1.0.0] - 2017-12-01
### Initial Release



[Unreleased]: https://github.com/Cloudbox/Cloudbox/compare/HEAD...develop
[1.0.1]: https://github.com/Cloudbox/Cloudbox/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/Cloudbox/Cloudbox/compare/9af69ab...v1.0.0
