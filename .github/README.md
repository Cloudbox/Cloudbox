<img src="cb_logo_1.gif" loop=0 width="200" alt="Cloudbox">


Cloudbox is an Ansible playbook for deploying a cloud media server stack on an Ubuntu server with the use of Docker containers.

This project is limited to specifically 16.04 Ubuntu LTS and AMD64/Intel64 (no ARM support) machines and designed for fresh systems. Do not install on an already setup server, or prepare for unintended consequences.

_If you find this this project helpful, feel free to make a small [donation via PayPal](https://www.paypal.me/l3uddz). Other forms of support are also appreciated (e.g. bugfixes, pull requests, etc)._

## Tools Installed


|                                                                 | Full | Feeder | Plex |
|:--------------------------------------------------------------- |:----:|:------:|:----:|
| [Docker][627bd283]                                              |  v   |   v    |  v   |
| [Plex][10952c53] ([docker][d369f92b])                           |  v   |        |  v   |
| [PlexPy][363c0adc] ([docker][cda70c13])                         |  v   |        |  v   |
| [Plex_AutoScan][96e27fd1]                                       |  v   |        |  v   |
| [Sonarr: develop][8ae81bb6] ([docker][a9b9645e])                |  v   |   v    |      |
| [Radarr: nightly][8211f62c] ([docker][a9b9645e])                |  v   |   v    |      |
| [NZBGet][2e2bad08] ([docker][a9b9645e])                         |  v   |   v    |      |
| [NZBHydra][a0cc8c46] ([docker][50ba3cbb])                       |  v   |   v    |      |
| [rTorrent][512b104c]/[ruTorrent][8d6ce857] ([docker][344a7c4b]) |  v   |   v    |      |
| [Jackett][1caa43a0] ([docker][a9b9645e])                        |  v   |   v    |      |
| [Rclone][b4cef019]                                              |  v   |   v    |      |
| [Plexdrive][0367302f]                                           |  v   |   v    |  v   |
| [PlexRequests][458fc748] ([docker][0044f8e1])                   |  v   |        |  v   |
| [Organizr][d328b256] ([docker][1e468891])                       |  v   |   v    |  v   |
| [Portainer][726e0b6f]                                           |  v   |   v    |  v   |
| [UnionFS-Fuse][6e8f308f]                                        |  v   |   v    |  v   |
| [UnionFS_Cleaner][f20acc3e]                                     |  v   |   v    |      |
| [Watchtower][a98faaaf]                                          |  v   |   v    |  v   |
| Kernel, motd, sysctl, etc...                                    |  v   |   v    |  v   |

  [627bd283]: https://www.docker.com "Docker"
  [10952c53]: https://www.plex.tv "Plex"
  [d369f92b]: https://github.com/plexinc/pms-docker "Official Docker container for Plex Media Server"
  [363c0adc]: https://github.com/JonnyWong16/plexpy "PlexPy"
  [cda70c13]: https://github.com/linuxserver/docker-plexpy "linuxserver/plexpy"
  [96e27fd1]: https://github.com/l3uddz/plex_autoscan "Plex_AutoScan"
  [8ae81bb6]: https://sonarr.tv "Sonarr"
  [8211f62c]: https://radarr.video "Radarr"
  [2e2bad08]: https://nzbget.net "NZBGet"
  [a0cc8c46]: https://github.com/theotherp/nzbhydra "NZBHydra"
  [50ba3cbb]: https://github.com/linuxserver/docker-hydra "linuxserver/hydra"
  [512b104c]: https://github.com/rakshasa/rtorrent/wiki "rTorrent"
  [8d6ce857]: https://github.com/Novik/ruTorrent "ruTorrent"
  [344a7c4b]: https://github.com/linuxserver/docker-rutorrent "linuxserver/rutorrent"
  [1caa43a0]: https://github.com/Jackett/Jackett "Jackett"
  [b4cef019]: https://rclone.org "Rclone"
  [0367302f]: https://github.com/dweidenfeld/plexdrive "Plexdrive"
  [6e8f308f]: http://manpages.ubuntu.com/manpages/zesty/man8/unionfs.8.html "UnionFS-Fuse"
  [f20acc3e]: https://github.com/l3uddz/unionfs_cleaner "UnionFS_Cleaner"
  [a98faaaf]: https://github.com/v2tec/watchtower "Watchtower"
  [458fc748]: https://github.com/lokenx/plexrequests-meteor "PlexRequests"
  [0044f8e1]: https://github.com/linuxserver/docker-plexrequests "linuxserver/plexrequests"
  [d328b256]: https://github.com/causefx/Organizr "Organizr"
  [1e468891]: https://github.com/linuxserver/docker-organizr "lsiocommunity/organizr"
  [726e0b6f]: https://portainer.io "Portainer"
  [a9b9645e]: https://github.com/hotio/docker-suitarr "hotio/suitarr"




## How To Guides

- See the [wiki](https://github.com/l3uddz/cloudbox/wiki) page.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

- See [changelog](CHANGELOG.md)

## Credits

- l3uddz (creator)
- desimaniac (contributor)