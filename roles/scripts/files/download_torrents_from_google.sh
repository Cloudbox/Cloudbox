if ! /usr/bin/screen -list | /bin/grep -q "torrents_download"; then
	/bin/rm -rfv /opt/scripts/rclone/download_to_disk.log
	/usr/bin/screen -dmS torrents_download /usr/bin/rclone copy google:/downloads/torrents /mnt/local/downloads/torrents --config=/home/seed/.config/rclone/rclone.conf --verbose=1 --transfers=8 --stats=60s --checkers=16 --drive-chunk-size=128M --fast-list --log-file=/opt/scripts/rclone/download_to_disk.log
fi