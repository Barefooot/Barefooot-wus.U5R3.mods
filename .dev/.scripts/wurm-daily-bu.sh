#!/bin/bash

path_server_root=/home/steam/wu
Creative_server_path=$path_server_root/Creative
db_path_backups=/home/steam/wu/backups
Creative_db_path_backups=$db_path_backups/Creative

for dbf in $Creative_server_path/sqlite/*.db
do
	fn=$(basename $dbf .db)

    echo -n "Processing $fn ... "
    echo ".backup $dbf.bu" | sqlite3 $dbf && echo " OK" || echo " FAIL"
done

zip -r   $db_path_backups/Ultima-V-Reficio.Creative_db_backup.$(date +"%Y-%m-%d_%H-%M-%S").zip   $Creative_server_path/sqlite/*.db.bu

#duplicity full --encrypt-key MYKEY $Creative_db_path_backups gs://wurm-bak/server
#duplicity remove-older-than 10D --force gs://wurm-bak/server

