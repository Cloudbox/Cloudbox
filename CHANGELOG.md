<!---

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

Changelog Format:

Body:

## [Unreleased][]

## [X.X.X][] - YYYY-MM-DD

Commits listed in ascending order based on the date.

Links:

[MAJOR_VERSION(X).MINOR_VERSION(Y).PATCH_VERSION(Z)]: https://github.com/cloudbox/cloudbox/compare/X.Y.Z-1...X.Y.Z

-->

# Changelog

## [Unreleased][]

## [1.3.2][] - 2018-12-14

- **Backup:** Backup task of systemd files will not copy symlinks anymore.
- **Sickbeard MP4 Automator:** Took out support for sonarr4k and radarr4k.
- **Changelog:** Format change
- **Organizrv1:** Added migration tasks to the role.
- **Common:** Add `jmespath` python module.
- **System:** Fix for broken `/etc/timezone` links.
- **Rclone:** Tweaking of permissions set by tasks. Config file will not be owned by root anymore.
- **Plex Autoscan:** Updated default config to match latest update.
- **Rclone:** Now checks to see if the version is available online before trying to install it. Will set to default (`latest`) version if not.
- **Rclone:** Reorganized role.
- **Git:** Added `*.pyc` files to gitignore.
- **Emby:** Specify version tags in `adv_settings.yml`.
- **Docs:** Updated `CONTRIBUTING.md` guide.
- **Docs:** Cleaner donation section in `README.md`.
- **System:** Renamed 'cpupower' task to 'remove_cpupower'.
- **System:** Moved vnstat task to system role.
- **System:** Added tso/tx disabling tweak for certain nics.
- **Backup:** Updated default paths. Only affects new users.
- **Suitarr:** Changed default image version to "unstable".
- **Restore:** Backup existing `/opt` folders before restoring to prevent overwriting them.
- **Traktarr:** Start service if previous config exists.
- **Plex Autoscan:** Swapped localhost domain to <https://plex.domain.com>.
- **Cloudplow:** Added nzbget section into default config.
- **NZBThrottle:** New role (thanks [davemaster223](https://github.com/daghaian)).
- **Plex:** Moved default transcodes folder out of `/home/`.
- **Docker:** Set all container's restart policty to `unless-stopped`.
- **Unionfs:** Suppress error message in output - when force unmounting.
- **Plexdrive:** Suppress error message in ouptput - when force unmounting.
- **Plex Autoscan:** Updated config
- **Plex Autoscan:** Update config items just in case it falls behind master.
- **Plex Autoscan:** Updates Plex Section Mappings automatically.
- **Plex Autoscan:** Only stop service (at beginning of role) when it was running before.
- **Plex Autoscan:** Added tag plex_autoscan_update_sections.
- **AppVeyor:** Patch version issues.
- **System:** Fix any potential dpkg issues.
- **Plex Auth Token:** Added tag entry into `cloudbox.yml`.
- **Settings:** Added an extra check to make sure `accounts.yml` is configured.
- **System:** Should now upgrade apt without config prompts.
- **Pre Tasks:** Reorganized user creation tasks.
- **Lets Encrypt:** Added UID/GID variables.
- **Cloudplow:** Added rclone_command option to config.
- **User:** Put user tasks into its own role.
- **Z:** Tweaked dot file tasks.
- **Watchtower:** Will now update all containers when installed.
- **Scripts:** HashRenamer.py - Catch hash type with 42 chars.
- **Nextcloud:** Split MariaDB tasks into its own role.
- **Sanity Check:** Allow non-Ubuntu releases to install CB but with a warning.
- **Pre-Install:** Set minimum Linux kernel version to 4.00.
- **Kernel:** Removed most of the kernel updating tasks. It was not compatible with all Ubuntu server types (eg VM).
- **Preinstall:** Gives recommended kernel message with kernel is between 4.00 and 4.10.
- **MariaDB:** Added tag to role.

## [1.3.1][] - 2018-11-08

- **Docker:** Added `docker-housekeeping` tag for Docker house keeping tasks.
- **Cloudplow:** Fixed missing comma in default config.
- **Kernel:** Added safeguards for when settings are undefined.
- **Plex:** Added safeguards, to db_cache_size task, for when settings are undefined.

## [1.3.0][] - 2018-11-08

- **Kernel:** Changed order in playbook file to run before/without settings updater.
- **Backup:** Removed plexdrive cache file from excludes list.
- **Ombi:** Corrected docker image name in role banner.
- **Backup:** Set rclone drive chunk size to 128M.
- **CloudPlow:** Set default config's rclone drive chunk size to 128M.
- **Restore:** Set rclone drive chunk size to 128M.
- **Scripts:** Added `download_torrents_from_google.sh` and `sync_torrents_to_google.sh`
  - Use to sync torrent download folder to google, and to copy from google to local disk.
  - Useful if wanting to keep downloaded torrents when moving server.
- **Plex:** Added db_cache_size option to `adv_settings.yml`.
- **Plexdrive:** Added `ExecStartPre` line to the service file to give it more time to start.
- **Organizr:** Updated docker image to `organizrtools/organizr-v2:plex`.
- **System:** Set vnstat to proper default interface.
- **System:** Replaced APT module for upgrading APT with shell command.
- **Settings:** Ansible will now quit after a new items are added to `adv_settings.yml`.
- **Pushover:** Reorganized tasks.
- **Backup:** Reorganized config and tasks.
  - Backup has a new playbook, `backup.yml`. Will allow for clean cron tasks.
  - Backup and Restore will also use a new settings file, `backup_config.yml`. This will make the main `settings.yml` easier to read for new users.
- **Shell:** Moved shell option from `adv_settings.yml` to `settings.yml`.
- **AppVeyor:** Updated to reflect new `backup_config.yml`.
- **TorrentCleaner:** Added fault tolerance to arguments.
- **Backup**: Renamed `backup_excludes.txt` to `backup_excludes_list.txt`.
- **Restore:** Restore backed up `backup_excludes_list.txt` file.
- **Backup:** Added support for Cloudbox Vault Service.
- **Backup:** Updated cron task to reflect new backup.yml playbook.
- **Restore:** Now calls Pre_Install role to make sure user account exists and create one if it doesn't.
- **Rclone:** `rclone.conf` will now be set to correct permissions, when importing from playbook dir.
- **Letsencrypt:** Store certs in `/opt/nginx-proxy/certs`.
- **Letsencrypt:** Migrate existing certs over to `/opt/nginx-proxy/certs`.
- **System:** Removed `cpupower.service`.
  - Was causing problems for certain users.
- **Kernel:** Added auto mainline kernel updater
  - By default, the kernel version `4.18.6` is installed (the most recent and stable version).
  - However, you can set a custom kernel version in `adv_settings.yml` as well. Be sure to put this in quotes or else trailing zeroes in single dot versions will drop off (eg `4.10` will become `4.1`).
- **Git:** Filter out `.DS_Store` for Macs.
- **Suitarr:** Added option to set Docker image version via `adv_settings.yml`.
  - Choices are `default` (let Cloudox decide), `image`, `stable`, and `unstable`.
  - Currently Cloudbox `default` is set to `unstable`.
- **ZSH:** Auto update Oh My Zsh without prompt.
- **Scripts:** PAS URL Script can now take `-s`/`--simple` arguments to pass only url with no formatting or banners.
- **Nginx-Proxy:** Updated proxy.conf to fix blocking of iframes.
  - Will not update existing installs. To do so, remove `/opt/nginx-proxy/proxy.conf` and rerun `nginx-proxy` tag.
- **Restore:** Renamed `/opt/` permissions fix tag to `opt-permissions-reset`.
- **Settings:** Will now exit just once after all the setting files have been updated vs exiting after each one.
- **Readme:** Expanded donation section.
- **NZBGet:** Adds unpauser schedule task to new config.
- **NZBGet:** Took out completion checker script for new installs.
  - Does not work too well (ie pause + download  + pause + download, etc is slower than just downloading until it fails and I also don't see a need for it when most have unlimited provider accounts, anyway).
  - If anyone still wants it, they can download themselves and drop it in the scripts folder.
- **Plex:** Renamed `allow_high_output_bitrates` to `force_high_output_bitrates` in `adv_settings.yml`.
- **Ansible:** Added new jinja filter 'pluralize'.
  - It's a modified version of the one available here: <https://github.com/audreyr/jinja2_pluralize>
- **Plexdrive:** Set max-chunks, in default service file, to `150` when system RAM is < 16 GB. Affects new users only.
- **AppVeyor:** Updated build number format. It will now be `Current Tag Version - New Commits since` (eg `1.2.9-118`).
- **Suitarr:** Set `default` docker image version to `image`.
- **[Sickbeard MP4 Automator](https://github.com/mdhiggins/sickbeard_mp4_automator):** New Role
  - Wiki guide: <https://github.com/Cloudbox/Cloudbox/wiki/Extra%3A-Sickbeard-MP4-Automator>
  - Initially submitted by andrewkhunn.
- **Resilio Sync:** Renamed role, `/opt` folder, and tag to `resilio-sync`. Subdomain is now `resiliosync`.
  - Existing installs will be migrated automatically when tag is ran.

## [1.2.9][] - 2018-09-26

- **Backup:** Removed traktarr.service checks.
- **Backup:** Added more safeguards for when a service file is disabled.
- **Backup:** Simplified Docker related messages.
- **Docker:** Added safeguard for when a service file is disabled.
- **Plexdrive:** Added safeguard for when service file is disabled.
- **UnionFS:** Added safeguard for when service file is disabled.
- **URL:** Updated url to <https://cloudbox.works>.

## [1.2.8][] - 2018-09-11

- **Sanity Check:** Will not check for tags when running community/cloudbox_mod.
- **Backup:** Adds `/opt/plex/.../cache/transcode` path into backup excludes.
- **Rclone:** Installs 'man-db'.
- **Pre-Install:** Converts all integer passwords to string.
- **Rclone:** Backup previous `rclone.conf` when moving one from playbook dir.
- **Rclone:** Cleans up legacy rclone install.
- **ruTorrent:** Moved location of watched folder setting in .rc file.
- **Backup:** Adds `set-backup` tag to toggle cron task.
- **Backup:** Removed dates from log file names.
- **Backup:** Sets cron task under user's crontab (vs root).
- **Backup:** Now creates a tarball for each folder in `/opt` vs just one `cloudbox.tar` file.
- **Restore:** Added support for restoring multiple tar files.
- **Python-PlexLibrary:** Script will now output log to display as well.
- **Cloudplow:** Set default config to skip symlinks during upload.
- **Backup:** Logs now go to `~/logs` vs `~/logs/backup/`.
- **Restore:** Will import rclone role when an rclone.conf exists in playbook dir.
- **Submodule:** ansible-ghetto-json
- **Settings:** Put all `*.defaults` into `defaults/` folder.
- **Permissions:** Moved permissions fix to restore.
- **Suitarr:** Added umask 002 permissions.
- **Organizr:** `direct_domain: yes` will not create or use the `organizr` subdomain.
- **Nginx:** Added support for customizable subdomain option via `adv_settings.yml`.
- **Pre-Tasks:** Added conditional to prevent errors when old or new downloads settings are missing in `settings.yml`.

## [1.2.7][] - 2018-08-21

- **Script:** Plex Autoscan URL tweaked grep command.
- **Rutorrent:** Added missing auth info to `nginx.conf`.

## [1.2.6][] - 2018-08-19

- **NZBHydra2:** Sets base to `null` value (new installs only).
- **Script:** 'Plex Autoscan URL Script' can now be run from any location.

## [1.2.5][] - 2018-08-19

- **Rutorrent:** Settings updated to match latest rtorrent release.

## [1.2.4][] - 2018-08-18

- **Hostess:** Added explicit download URL as failsafe.
- **Ctop:** Added explicit download URL as failsafe.
- **WebTools:** Added explicit download URL as failsafe.
- **WebTools:** Display version installed.
- **Shell:** `shell` role replaces `zsh` and `bash` roles.
  - Use `adv_settings.yml` to switch between them.
- **Pre-Install:** Cleaned up role a bit.
- **Pre-Install:** Created variable `cloudflare_enabled`.
- **Cloudflare:** Made use of cloudflare_enabled variable.
- **Git:** Added `rclone.conf` to `.gitignore` so that having it in the `cloudbox` folder does not put the folder out of sync.
- **Ansible:** Enabled hash merge behavior (`hash_behavior`) in `ansible.cfg` (for new users).
- **Backup:** Added a default `backup_excludes.txt` into the backup role.
  - If you want to have a custom excludes list, simply drop a `backup_excludes.txt` file in the cloudbox folder, and backup will use that one instead.
- **Variables:** Created universally accessible `uid`, `guid`, and `vgid` variables.
- **Kernel:** Will quit now if kernel is already updated.
- **Common:** Adds multiverse APT repositories.
- **Common:** Added `common` tag to role.
- **Plex:** Reorganized Host Tasks (thanks [EnorMOZ](https://github.com/EnorMOZ)).
- **Plex:** Added support for entering in login info in `accounts.yml`.
  - This will bypass the claim code prompt and automate everything needed to setup Plex.
  - Based on the work by [EnorMOZ](https://github.com/EnorMOZ).
- **Backup:** Added `ANSIBLE_CONFIG` env variable to cron task.
- **Backup:** Added `--skip-tags settings` to the cron task.
- **Scripts:** Updated paths for nzb scripts.
  - Will now go to `/opt/scripts/nzbs/`.
- **Scripts:** Updated paths for torrent scripts.
  - Will now go to `/opt/scripts/torents/`.
- **System:** Certain kernel versions that have no matching linux-tools will no error out anymore.
- **Settings:** Automatically adds in `hash_behavior` into `ansible.cfg` if missing (for current users).
- **Settings:** New downloads folder structure.
  - This will allow for more downloaders to be added without the need to modify PVR (eg Sonarr) mounts.
  - Left backwards compatibility for previous downloads folder settings (for now). But will _eventually_ remove them from from there (`settings.yml`).
- **Variables:** Created `old_downloads_settings` and `new_downloads_settings` variables.
- **NZBGet:** Support for the new downloads path settings.
- **ruTorrent:** Support for the new downloads path settings.
- **Sonarr:** Support for the new downloads path settings.
- **Sonarr4K:** Support for the new downloads path settings.
- **Radarr:** Support for the new downloads path settings.
- **Radarr4K:** Support for the new downloads path settings.
- **Rclone:** Added in failsafes for incorrect version numbers etc. Will revert to `latest` version if no setting is specified.
- **Rclone:** Now supports `beta` tag as well.
- **Docker:** Installs `docker-ce 18.05.0` for all Ubuntu versions.
- **Plex:** Create some folders ahead of time. Prevents container from creating them in root.
- **Nginx-Proxy:** Creates `vhost.d` folder.
- **Scripts:** Changed `nzbs` folder to `nzbget`.
- **[SABnzbd](https://sabnzbd.org):** New role.
  - Install tag: `--tags sabnzbd`
  - After setup wizard finishes, it will try to redirect to `domain:8080`. Just take out the `:8080` part and it will be OK from then on.
  - User will also need to add in categories for sonarr, radarr, and lidarr. Was also not able to do that without server already filled in.
  - Direct unpack is disabled by default. Left it as-is for user to setup.
- **Scripts:** Added scripts folder for `sabnzbd`.
- **Plex Dupefinder:** Renamed sample config' TV library name as "TV Shows" to match Plex's default one.
- **Plex Auth Token:** New role.
  - Used to generate plex auth tokens.
  - Requires Plex login info in settings.
  - Can use `--tags plex_auth_token` to print out the token.
- **Plex Autoscan:** Pre-filled Plex token when Plex login is set.
- **Cloudplow:** Pre-filled Plex token when Plex login is set.
- **Plex Dupefinder:** Pre-filled Plex token when Plex login is set.
- **Plex Patrol:** Pre-filled Plex token when Plex login is set.
- **SABnzbd:** Role exists when new download path settings are not set.
- **SABnzbd:** Presets login based on user/passwd from `accounts.yml`.
- **Docker:** Replaced the pip module `docker-py` with `docker`.
- **Backup:** Moved `~/logs/` to `~/logs/backup/`.
- **Common:** Install `lxml` for Ansible's XML module.
- **Plex:** Added 'Forced Automatic Quality Settings' (experimental)
- **Docker:** Added `purge_networks: yes` to all container tasks.
- **Docker:** Reworked `cloudbox` docker network
- **Nginx:** New role. 'Nginx' web server.
  - Can be used to host websites.
  - Access via www.domain.com or domain.com.
- **Pre-Install:** Migrates folder to home location.
- **Settings:** Went back to saving log files in cloudbox folder.
- **Lidarr:** Support for the new downloads path settings.
- **Pre-Tasks:** Created variables for downloads path settings.
- **NZBGet:** Support for "new and improved downloads path variables".
- **ruTorrent:** Support for "new and improved downloads path variables".
- **SABnzbd:** Support for "new and improved downloads path variables".
- **Lidarr:** Support for "new and improved downloads path variables".
- **Sonarr:** Support for "new and improved downloads path variables".
- **Sonarr4K:** Support for "new and improved downloads path variables".
- **Radarr:** Support for "new and improved downloads path variables".
- **Radarr4K:** Support for "new and improved downloads path variables".
- **MOTD:** Peek is default banner type.
- **Docker:** Added Housekeeping tasks.
- **Emby:** Presets baseline settings
- **Lidarr:** Now part of default install for 'cloudbox' and 'feederbox' (based on poll results).
- **Plex Autoscan:** Added Music section into PLEX_SECTION_PATH_MAPPINGS for default config.
- **NZBGet:** Set scripts path to /scripts/nzbget
- **Plex:** Mounted `/scripts` to plex.
- **Netdata:** Added HTTP auth.
- **Organizr:** Moved previous `organizr` to  `organizrv1` as legacy support.
  - use `--tags organizrv1` to install.
  - subdomain: `organizrv1`
  - `direct_domain` settings do get applied to this. So if you want to have both versions, turn the setting off before installing the other.
- **Organizr:** Added Organizr v2 (beta) (from here on will be referred to as just 'Organizr')
  - will migrate over folder of previous version from `/opt/organizr` to `/opt/organizrv1`.
- **Plex:** Added `adv_settings.yml `option to open/close port 32400 on host.
- **OrganizrV1:** Took out support fro `direct_domain` option in `adv_settings.yml`. Can now only be used with a subdomain.
- **Organizr:** Added Plex theme support.
- **Ombi:** Replaces 'Plex Requests' for default installs ('cloudbox' and 'mediabox').
- **Feeder:** Mount and Dismount tags renamed to match role names.
- **Python-PlexLibrary:** Renamed 'PlexLibrary' to 'Python-PlexLibrary' to match GitHub repo name.
- **Sanity Check:** Deletes stale `backup.lock` files, automatically.
- **Permissions:** Swapped `0755` to `0775` for all permission tasks.
- **Permissions:** Swapped `0644` to `0664` for all permission tasks.
- **Common:** Install `httpie`.
- **NZBGet:** Prefetch some commonly used scripts.
- **Scripts:** Renamed `nginx` scripts folder to `nginx-proxy`.
- **NZBGet:** Removed `SafeRename.py` as it did not work too well.
- **Script:** 'Plex Autoscan URL Script' now supports vaulted `accounts.yml`.
- **Traktarr:** Automatically adds in Sonarr and Radarr API keys into `config.json`.
- **Common:** Install `zip`.
- **Common:** Will only reset `/opt` permissions if folder age >= 7 days.
- **Common:** Install `apprise`.
- **NZBGet:** Added `HashRenamer.py` PP script.
- **Pushover:** Added support for message priority.
- **Docker:** Adds `"com.github.cloudbox.cloudbox_managed": "true"` label to all CB for future use.
- **Common:** Install `subliminal`.
- **Restore:** Added 'Local Only Mode'.
  - Will use local backup for restores when present.
- **Backup:** Will now only stop/start Cloudbox-managed Docker containers during backup.
- **Telly:** Updated to reflect recent changes.
- **Webtools:** Added tag `reinstall-webtools`
- **Shell:** Copy `.bashrc` from `/etc/skel` when missing.
- **Backup:** Added accounts.yml to backed up files list.
- **Settings:** Addition of `accounts.yml`.
  - Shifting of account related settings from settings.yml into accounts.yml.
- **Ansible:** Skip installing certain apps if downloads paths are left blank (on purpose).
- **Docker:** Changed docker start up delay to 30s post unionfs (from 120s). 120s delay was just not needed.
- **Docker:** Service is always stopped/started during the role runtime.
- **Pushover:** Now in `accounts.yml`. Still backwards compatible with old location under backup.

## [1.2.3][] - 2018-07-09

- **Plex Autoscan:** Added `--loglevel=INFO` to service file.
- **Cloudplow:** Added `--loglevel=INFO` to service file.
- **Cloudplow:** Added Rclone throttle speeds settings into default config.
- **Suitarr:** Updated migration helper tasks to reflect recent changes.
- **Scripts:** Added 'Plex Trash Fixer' script.
- **ZSH:** Sets correct permissions during repo clone.
- **Z:** Sets correct permissions during repo clone.
- **[Python-PlexLibrary](https://github.com/adamgot/python-plexlibrary):** New role.
- **Backup:** Minor tweaks to Docker start / stop tasks.
- **Backup:** Excludes reflect new Sonarr/Radarr Mediacover paths.
- **Rclone:** Will attempt to look for missing `rclone.conf`, and if found, move it to the correct 'default' location.
- **Bash:** New role.
- **Shell:** Add `nano` as default editor.
- **Ansible:** Turned off retry files.
- **Ansible:** Turned off retry files.
- **NZBGet:** Updated settings subtasks to match new Suitarr config location.
- **NZBHydra2:** Updated settings subtasks to match new Suitarr config location.
- **System:** Added `system` tag.
- **NodeJS:** Separated into its own role.
- **NodeJS:** Will now output NodeJS, npm, and frontail versions once installed.
- **Docker:** Added `docker` tags.
- **Docker:** Will stop and start running containers on task run.

## [1.2.2][] - 2018-06-25

- **Suitarr:** Updated Docker images to new format.
- **[Bazarr](https://github.com/morpheus65535/bazarr):** New role ([setup instructions](https://github.com/Cloudbox/Cloudbox/commit/bac132438267c36a5ea86c09e6a20f0c63273e55)).
- **Sonarr4K:** New role.

## [1.2.1][] - 2018-06-24

- **NZBHydra2:** Increase JVM memory to 512 MB when system has 8 GB of RAM or more.
- **Cloudplow:** Adds \*\*.fuse_hidden\*\* to rclone excludes.
- **Cloudplow:** Adds Plex integration into default config.
- **Heimdall:** Turns on http login authentication by default.
- **Organizr:** Adds `www` subdomain to Organizr when `direct_domain` is set in `adv_settings.yml`.
- **ZSH:** Now installed by default.
  - To switch to bash, set `shell: bash` in `adv_settings.yml` and run the `shell` tag.
- **System:** Only updates ext4 mount.
- **NZBGet:** Fixes missing env's for new installs.
- **[Z (jump)](https://github.com/rupa/z)** - New role.
- **[NowShowing](https://github.com/ninthwalker/NowShowing)** - New role.
- **Plex Autoscan:** Updated config to support latest changes.
- **Nginx-Proxy:** Allows EPGs with large channel data to be added in to Plex. (_[EnorMOZ](https://github.com/EnorMOZ)_)
- **Plexpy:** `/scripts/plexpy/` points to `/opt/scripts/plexpy/`.
- **Scripts:** Torrent Cleaner - Experimental support for Lidarr.
- **NZBGet:** Tweaked /scripts mount path.
- **ruTorrent:** Tweaked /scripts mount path.
- **Pre-Install:** Set ownership of entire `/home/{{user}}` folder to `{{user}}:{{user}}`.

## [1.2.0][] - 2018-06-17

- **Kernel:** Added `PATH` to cron task fix issues with purge-old-kernels.
- **General:** Added support for 18.04/18.10 (thanks [EnorMOZ](https://github.com/EnorMOZ)).
- **Settings:** Added support for `adv_settings.yml` For misc/advanced settings that that don't seem to fit in the main `settings.yml` file.
- **Organizr:** Direct domain option in `adv_settings.yml`.
- **Ombi:** Custom subdomain option in `adv_settings.yml`.
- Plex Requests: Custom subdomain option in `adv_settings.yml`.
- **System:** Removes useless packages and dependencies.
- **[Telly](https://github.com/tombowditch/telly):** New role (thanks [EnorMOZ](https://github.com/EnorMOZ)).
  - Options are set in adv_settings.yml.
- **Common:** Install [iperf3](https://software.es.net/iperf/).
- **Ctop:** display the version after install.
- **Hostess:** display the version after install.
- **Settings:** Took out entry for Plex Autoscan IP, as it's usually 0.0.0.0 for CB purposes.
- **NZBGet:** Fixed unrar issue with latest version of NZBGet (thanks [RXWatcher1](https://github.com/RXWatcher1)).
- **Sanity Check:** Exit any CB install when backup is in progress.
- **NZBHydra1:** Switched to LSIO image as Hotio/Suitarr dropped support.
- **NZBHydra2:** NZBHydra2 now replaces NZBHydra1 for "default" installs (i.e. `cloudbox` and `feederbox`).
- **Plex Autoscan:** Added music folder into default config.
- **Feeder Mount Role:** New Role. Mounts rclone feeder remote onto the `/mnt/feeder` path of a Plexbox.
- **Pre-Tasks:** Cloudbox related subdomains are now: `cloudbox`, `plexbox`, `feederbox`.
  - Don't put these behind proxy/CDN, as these are meant to reach your server directly.
- **Pre-Tasks:** Removes cloudbox subdomain for plex/feeder box installs.
- **Ansible:** Added localhost to inventory to suppress warning messages.
- **PIP:** Suppress outdated pip warnings.
- **[Nethogs](https://github.com/raboof/nethogs):** New role (thanks [EnorMOZ](https://github.com/EnorMOZ)).
- **[Cloudplow](https://github.com/l3uddz/cloudplow/):** Cloudplow replaces UnionFS Cleaner.
- **Rutorrent:** Disables `extsearch` plugin for new and old installs.
  - Will help fix some slow loading issues.
- **Scripts:** 'Plex Autoscan URL Script' will now catch errors and display the error message (e.g. missing dependencies, invalid JSON formatting). Also Added some visual enhancements.
- **Feeder Dismount Role:** New Role. Reverts all changes from Feeder Mount role.
- **Sanity Check:** Make sure users are using a valid tag (thanks [EnorMOZ](https://github.com/EnorMOZ)).
- **Rutorrent:** Uses same password as `passwd` in `settings.yml`.
- **NZBHydra1:** Config files for Suitarr path now automatically migrated over to LSIO path.
- **NZBHydra2:** Automates entering in login and auth info, and sets JVM memory to 512MB if the system has >= 16GB of RAM.
- **NZBHydra2:** Mounts NZBHydra1, so that previous config/db can be migrated on first install or from settings later.
  - See <https://i.imgur.com/CneRSWw.png> for the paths needed.
- **Backup:** Excludes `/opt/sonarr/MediaCover` and `/opt/radarr/MediaCover`.
- **Suitarr:** Updated tasks to reflect new config paths.
- **Ansible**: Tags updates.
  - `core` (new)
  - `full` -> `cloudbox`
  - `plex` -> `mediabox`
  - `feeder` -> `feederbox`
  - `update-` and `install-` prefixes removed from all tags
  - To see a full list of tags: `sudo ansible-playbook cloudbox.yml --list-tags`

## [1.1.3][] - 2018-05-21

- **Plex:** Will auto-update to the latest WebTools version.
- **Common:** Install/Update to latest ctop version.
- **Common:** Install/Update to latest hostess version.
- **Webtools:** Moved into a separate role.
- **AppVeyor:** Will now install the default Ansible version in the Dependencies Installer Script.
- **Cloudflare:** Task name shows correct IP address, now.

## [1.1.2][] - 2018-05-19

- **Cloudbox:** Added headers to all roles and scripts.
- **Ansible:** Fixed misc warning messages.

## [1.1.1][] - 2018-05-19

- **Backup:** systemd-backup now uses synchronize, should avoid issues with copy module failing on 0 byte files.
- **Docker:** Better log size management (thanks [EnorMOZ](https://github.com/EnorMOZ)).
- **ZSH:** Existing .zshrc file will no longer be replaced with default one.
- **[Plex Patrol](https://github.com/l3uddz/plex_patrol):** New role.
- **Watchower:** now an optional module.
- **MOTD:** Replaced generic MOTD with [Cloudbox MOTD](https://github.com/cloudbox/cloudbox_motd), a Cloudbox-enhanced MOTD.
- **AppVeyor:** CI testing added.
- **Cloudflare:** Now only creates a single subdomain entry.
- **Backup:** Exclude Plex cache folder in backup.
- **Common:** Installs unrar-free if unrar could not be installed.
- **Common:** `netaddr` is now installed via the Dependency Installer script instead of Ansible.
- **ZSH:** Will now link to /bin/zsh if it doesn't already do so.
- **Kernel:** Now runs without settings-updater checks.
- **Common:** Set `/opt` to `ugo+X` instead of `0775`.
- **Rutorrent:** Added `stop_timeout` to Docker container.
- **Docker:** Updated to `18.03.1`.
- **Readme:** Added feathub link.
- **PlexPy:** Now downloads nightly version.
- **Nginx-Proxy:** Renamed update tag to `update-nginx-proxy` vs `update-nginx`.
- **Cloudflare:** (Real) Public IP Address will now be used.
- **Common:** Node.js Updated to `v10.X`.
- **Backup:** Logs are created in `~/logs/` path.
- **Pre-Install:** No longer changes the user's shell on Cloudbox run (eg `full`).

## [1.1.0][] - 2018-04-18

- **Docker:** Force the installation of `docker-ce v17.09.0`
  - This is to prevent issues mentioned here: <https://github.com/moby/moby/issues/35933>.
- **General:** Fixed misc SSL errors with Github links.
- **Git:** Added `.gitignore` to repo.
  - `git pull` will no longer have conflicts with logs, retry files, etc.
- **Docker:** Prevent it from being updated by placing version "on hold".
- **Backup:** Added `keep_local_copy` option in `settings.yml` to keep or remove local backup (`cloudbox.tar`).
  - During backup, if `use_rclone`/`use_rsync` is `false` and `keep_local_copy` is set to `true`, then backup will be made to local file only.
  - During restore, if `keep_local_copy` is set to `true` and a local backup file (`cloudbox.tar`) exists, then that local backup file will be used for the restore task (no rclone / resync download of a remote `cloudbox.tar` file will occur).
  - This is handy for when a user just wants to drop in a backup file and restore from it.
- **Unionfs:** Modified `unionfs.service` file to added 30 second wait to start to UnionFS.
  - Gives extra time for other mounts to be loaded before Unionfs starts.
  - This helps with users who..
    1. have more than one mounts setup (eg rclone sftp mount for a feederbox), and
    1. are using encrypted rclone mounts with plexdrive (takes longer to start up).
- **Rclone:** Set binary location to `/usr/bin/rclone` (as documented [here](https://rclone.org/install/).
  - Removed the use of `/opt/rclone/` folder (and the symlinks within it).
- **ZSH:** New role.
  - This will install ZSH & [Oh My Zsh](http://ohmyz.sh), and set it as the default shell.
  - install: `--tags install-zsh`
  - config: `~/.zshrc`
  - This role does not run with default install.
- **Plex:** Added hosts required for [Lazyman Plex Channel](https://github.com/nomego/Lazyman.bundle).
- **Common:** installs `netaddr` python module for Ansible's `ipv4` filter.
- **[Traktarr](https://github.com/l3uddz/traktarr):** New role.
- **Settings:** Added new Settings Updater role.
- **Scripts:** Added new script: `arrpush.py` (for ruTorrent autodl-irssi)
- **Scripts:** Renamed `arrpush.sh` (the previous script) to `arrpush.legacy.sh`.
- **Scripts:** Moved script folder creation tasks here.
- **Commmon:** installs `dnspython` python module for Ansible's `dig` lookup.
- **Scripts:** Added tag: `--tags update-scripts`.
- **Ctop:** version updated to `0.7.1`.
- **Common:** installs [screen](https://www.gnu.org/software/screen/manual/screen.html).
- **Common:** installs [tmux](http://man.openbsd.org/OpenBSD-current/man1/tmux.1).
- **Resilio Sync:** Switched to official Resilio Docker image.
  - Advanced options now persist after restart.
  - Files created retain correct permissions.
- **[Plex Dupefinder](https://github.com/l3uddz/plex_dupefinder/):** New role.
- **Ombi:** Switched to `linuxserver/ombi` image (as it now installs v3).
- **Scripts:** Added [Dependency Installer Script](https://github.com/cloudbox/cloudbox/wiki/First-Time-Install%3A-Downloading-Cloudbox#1-install-dependencies).
  - Simple, clean install script.
  - Fixes potential pip issues.
- **[Radarr4K](https://radarr.video):** New role.
  - Basically, just an extra copy of Radarr to be used for any purpose, including the building of a 4K only library.
  - subdomain: `radarr4k`
  - install: `--tags install-radarr4k`
  - folder: `/opt/radarr4k/`
  - Uses port `7879`.
  - Only mounts `/mnt/`
    - User's choice on where to keep 4K movies.
    - Examples:
      -  `/mnt/unionfs/Media/Movies/Movies4K/`
      -  `/mnt/unionfs/Media/Movies4K/`
  - Plex Autoscan will also require tweaking. See "Configuring Plex Libraries" wiki page for more info.
- **[Heimdall](https://heimdall.site/):** New role (thanks [TheBradz](https://github.com/TheBradz)).
- **Nginx Proxy:** Added in HTTP Authentication support. See [here](https://github.com/Cloudbox/Cloudbox/wiki/HTTP-Auth-Support) for more details.
- **Rclone:** fix for trailing zeroes in version numbers.
- **[The Lounge](https://thelounge.chat/):** New role.
- **Cloudflare:** Added [Cloudflare DNS](https://www.cloudflare.com/) support
  - Added `cloudflare_api_token` to `settings.yml`.
  - When API token is filled in, Cloudbox will automatically create DNS entries (non proxied/CDN), and/or update them with the host's IP address, when relevant tasks are run.
  - Will also add one of 3 relevant subdomains: `plexbox`, `feederbox`, or `cloudbox`.
    - This is useful for ssh, ftp, etc, especially with a Feederbox/Plexbox setup.
  - This requires the email address in `settings.yml` to match the one used for the Cloudflare account.
- **MOTD:** Now shows memory info (based off the word by [EnorMOZ](https://github.com/EnorMOZ)).
- **Ansible:** Added command_warnings: off
- **[Netdata](https://my-netdata.io):** New role.
- **Pre-Install:** Set `sudo` group to `NOPASSWD`
  - No more password prompts when running sudo commands.
- **Rclone:** use `latest` for rclone version in `settings.yml` to always install the latest version.
  - Version numbers can still be used (e.g.`1.40`).
- **[ZNC](https://wiki.znc.in/ZNC):** New role.
  - Uses ZNC Docker image by [horjulf](https://github.com/horjulf/docker-znc).
  - subdomain: `znc`
  - install: `--tags install-znc`
  - folder: `/opt/znc`
- **Scripts:** Removed `cloudflared.py` as this is not needed anymore.
- **[Quassel IRC Core](https://quassel-irc.org/):** New role.
- **Rclone:** `rclone.conf` location: `~/.config/rclone/rclone.conf`.
- **Backup:** Rclone uses less bandwidth, due to server-side move commands (initially submitted by [RXWatcher1](https://github.com/RXWatcher1)).
- **Backup:** Will archive older versions of `cloudbox.tar` on Rclone remotes (initially submitted by [RXWatcher1](https://github.com/RXWatcher1)).
- **Backup:** Systemd files will be saved to `/opt/systemd-backup` (vs `/opt/systemd`).
  - The name makes the purpose of the folder clearer.
- **Backup:** Local `cloudbox.tar.backup` file is now deleted after a successful tar archiving task.
- **Backup:** Will now keep `rclone.conf` and `settings.yml` files separate from `cloudbox.tar`.
- **Restore:** Looks for `rclone.conf` in `~/cloudbox/` and, if found, moves it to `~/.config/rclone/rclone.conf`.

## [1.0.2][] - 2018-2-22

- **[Lidarr](http://lidarr.audio/):** New role.
- **ruTorrent:** Now uses [ruTorrent Docker image by horjulf](https://github.com/horjulf/docker-rutorrent-autodl).
- **WebTools:** Updated to v3.0.0 (to update, see this [here](https://github.com/cloudbox/cloudbox/wiki/FAQ#update-webtools) page).
- **[Emby](https://emby.media/):** New role.
- **[NZBHydra2](https://github.com/theotherp/nzbhydra):** New role.
- **PlexPy:** Now installs PlexPy v2 (aka Tautulli).

## [1.0.1][] - 2017-12-30

- **Common:** Installs `ansible-toolbox`.
- **[Ombi](http://www.ombi.io/):** New role.
- **Scripts:** Arrpush - minor adjustments
- **[Resilio Sync](https://www.resilio.com/):** New role.
- **[Glances](https://nicolargo.github.io/glances/):** New role.
  - Command line tool; simply run `glances`.
- **[Nextcloud](https://nextcloud.com/):** New role.
- **Suitarr:** Docker containers now use default app ports.
  - This effects Sonarr, Radarr, NZBGet, NZBHydra, and Jackett.

## [1.0.0][] - 2017-12-01

- **Initial**: First "GitHub release".

[Unreleased]: https://github.com/cloudbox/cloudbox/compare/HEAD...develop
[1.3.2]: https://github.com/cloudbox/cloudbox/compare/1.3.1...1.3.2
[1.3.1]: https://github.com/cloudbox/cloudbox/compare/1.3.0...1.3.1
[1.3.0]: https://github.com/cloudbox/cloudbox/compare/1.2.9...1.3.0
[1.2.9]: https://github.com/cloudbox/cloudbox/compare/1.2.8...1.2.9
[1.2.8]: https://github.com/cloudbox/cloudbox/compare/v1.2.7...1.2.8
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
