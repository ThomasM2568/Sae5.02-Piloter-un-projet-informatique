#!/bin/bash

source_directory="/root/script"
nas_backup_directory="//10.0.50.1/partage/backup/"
local_backup_directory="/root/save/script/"
github_backup_directory="/root/save/github/"
backup_filename="backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

############################
#    Local save copy       #
############################
tar -czvf "$local_backup_directory$backup_filename" "$source_directory"

############################
#         NAS save         #
############################
cp "$local_backup_directory$backup_filename" "$nas_backup_directory$backup_filename"

############################
#         Github           #
############################
cd "$github_backup_directory"
git add "$backup_filename"
git commit -m "Nouvelle sauvegarde $(date +'%Y-%m-%d %H:%M:%S')"
git push https://github.com/ThomasM2568/sae502/script/automation.git master

############################
#     Local save           #
############################
additional_local_backup_directory="/mnt/usb_drive"
cp "$local_backup_directory$backup_filename" "$additional_local_backup_directory$backup_filename"


echo "Done"
