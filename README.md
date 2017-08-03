# Cloudbox

Cloudbox is an Ansible playbook for deploying a cloud media server stack on an Ubuntu server with the use of Docker containers.

>This project is limited to specifically 16.04 Ubuntu LTS, designed for fresh systems. Do not install on an already setup server, or prepare for unintended consequences.


## Tools Installed


|                              | Full Cloudbox | Feeder Cloudbox | Plex Cloudbox |
|:---------------------------- |:-------------:|:---------------:|:-------------:|
| Docker                       |       √       |        √        |       √       |
| Plex (docker)                |       √       |                 |       √       |
| PlexPy (docker)              |       √       |                 |       √       |
| Plex Autoscan                |       √       |                 |       √       |
| Sonarr (docker)              |       √       |        √        |               |
| Radarr (docker)              |       √       |        √        |               |
| Nzbget (docker)              |       √       |        √        |               |
| NZB Hydra (docker)           |       √       |        √        |               |
| rTorrent/ruTorrent (docker)  |       √       |        √        |               |
| Jackett (docker)             |       √       |        √        |               |
| Rclone                       |       √       |        √        |               |
| PlexDrive                    |       √       |        √        |       √       |
| UnionFS                      |       √       |        √        |       √       |
| UnionFS Cleaner              |       √       |        √        |               |
| Watchtower (docker)          |       √       |        √        |       √       |
| Kernel, motd, sysctl, etc... |       √       |        √        |       √       |



## Installation

### Installing Ansible

Run these commands:
```bash
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

### Cloning Git Project

1. Go to home folder:

  ```bash
  cd ~/
  ```

2. Clone project:

  ```bash
  git clone https://github.com/l3uddz/cloudbox
  ```

### Running the Ansible script

1. Go into cloudbox folder

  ```bash
  cd cloudbox
  ```

2. Decide on what type of Cloudbox you want: `full`,`feeder`, or `plex` .

3. Run the following Ansible command, with the preferred option from #2 (`--tag "option"`) - quotes not needed.

  Example:

  ```bash
  sudo ansible-playbook cloudbox.yml --tag full
  ```

## Customization

See wiki.

## Usage

TODO: Write usage instructions

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

TODO: Write history

## To Do

- simpler install method

## Credits

TODO: Write credits

## License

TODO: Write license
