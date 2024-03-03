#!/bin/sh
mkdir -p /home/main/.logs
touch /home/main/.logs/rclone.log
rclone bisync /home/main/Games/data/yuzu GoogleDrive: --log-file /home/main/.logs/rclone.log -vv
