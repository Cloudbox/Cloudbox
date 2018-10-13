if ! /usr/bin/screen -list | /bin/grep -q "torrents_sync"; then
	/bin/rm -rfv /opt/scripts/rclone/sync_to_google.log
	/usr/bin/screen -dmS torrents_sync /usr/bin/rclone sync /mnt/local/downloads/torrents google:/downloads/torrents --config=/home/seed/.config/rclone/rclone.conf --verbose=1 --transfers=8 --stats=60s --checkers=16 --drive-chunk-size=128M --fast-list --log-file=/opt/scripts/rclone/sync_to_google.log
fi