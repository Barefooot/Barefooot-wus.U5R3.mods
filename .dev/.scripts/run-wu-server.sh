#!/bin/sh


# CONTROL PANEL
##Backup
bu_max_days=14
path_backups="/home/steam/wu/backups"

#Server
path_server_root="/home/steam/wu"
server_launcher_file='./WurmServerLauncher-patched'		#server_launcher_file='./WurmServerLauncher'
server_name="[NEW/PvPvE/ENG] Ultima-V-Reficio-Kingdoms,Epic,Fast-Paced,FREE-No pay to win,Coming soon-in alpha testing"
server_max_players=250
server_start=Creative



# SEE 'Detecting Command Line Arguments' - http://linuxcommand.org/lc3_wss0120.php
if [ "$1" != "" ]; then
    echo "Skipping backup phase"
else	#Positional parameter 1 is empty
	echo Starting to backup WU servers
	zip -r   $path_backups/Ultima-V-Reficio.backup.$(date +"%Y-%m-%d_%H-%M-%S").zip   $path_server_root/mods/   $path_server_root/Creative/   $path_server_root/scripts/ 			#zip creative+mods with time-stamp as a name
fi


echo Removing older than $bu_max_days [days] backup files
find $path_backups/ -type f -mtime +$bu_max_days -name '*.zip' -execdir rm -- '{}' \;

exit 0
echo running wurm server cluster, start=$server_start
cd $path_server_root
cp ./linux64/steamclient.so ./nativelibs


### SEE https://www.wurmpedia.com/index.php/Server_administration_(Wurm_Unlimited)#Command_Line_Arguments
$server_launcher_file   start=$server_start   maxplayers=$server_max_players   servername="$server_name" & 
