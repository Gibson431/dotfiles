#!/bin/sh
mkdir -p /home/main/.logs
mkdir -p /home/main/Games/data/yuzu
touch /home/main/.logs/rclone.log
rclone bisync /home/main/Games/data/switch/ GoogleDrive: --log-file /home/main/.logs/rclone.log -vv
