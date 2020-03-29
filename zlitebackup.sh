#!/bin/bash

#ssh-keygen
#ssh-copy-id zulu@localhost

echo "Script de backup économique automatique de Full/Différentiel"
echo "Use: ./zlitebackup"
echo "zf 1200711.1704,150209.0838,150625.2241, 161205.1115 200329.2301"

GREEN='\033[1;32m'
NOCOL='\033[0m'

echo -e ${GREEN}$0 "start...$(date)"${NOCOL}

###########################
# Paramètres à modifier ! #
###########################
# Simplement commenter la ligne SIMULATION pour ne plus simuler le backup !

#SIMULATION='-n'

# SOURCE='/Users/zuzu'
# SOURCE="'/Users/zuzu/Google Drive/Privé/Famille Zufferey/Impôts'"
SOURCE="'/Users/zuzu/Google Drive/Privé/'"

#TARGET_MACHINE='root@ditsup-naszf2.epfl.ch'
TARGET_MACHINE="zuzu@localhost"

#TARGET='/volume1/zuzu/Backups/iMac-Zf'
TARGET="/Volumes/backupzf1/Backups/macbookprozf-test1456"


#EXCLUDE='--exclude=**/ImapMail/ --exclude=**/zlitebackup/ --exclude=**/*tmp* --exclude=**/.cache* --exclude=**/cache* --exclude=**/Cache* --exclude=**/lost+found* --exclude=**/*rash*  --exclude=**/mnt/* --exclude=**/.VirtualBox* --exclude=**/VirtualBox* --exclude=**/.evolution* --exclude=**/.mozilla* --exclude=**/.opera* --exclude=**/.macromedia* --exclude=**/.navicat* --exclude=**/google-earth* --exclude=**/.local/share/gvfs* --exclude=**/.thumbnails* --exclude=**/Picasa2/db3* --exclude=**/.gvfs* --exclude=**/.wine* --exclude=**/chromium/*'

EXCLUDE='--exclude=**/Library* --exclude=**/mnt* --exclude=**/.Trash* --exclude=**/.atom* --exclude=**/VirtualBox?VM?Masters* --exclude=**/VirtualBox?VMs* --exclude=**/.vagrant.d/boxes*'

###########################

YEAR=`date +%Y` 
MONTH=`date +%m`
DAY=`date +%d`
TIME=`date +%H-%M-%S` 
DIFF='diff/'${YEAR}/${MONTH}/${DAY}/${TIME}

COMMAND='-i -r -t -v --progress --stats --size-only --modify-window=1 --delete-excluded'
#COMMAND='-r -t -v --progress --stats --size-only --modify-window=1 --delete-excluded'
#COMMAND='-r -t -v --progress --stats --checksum --modify-window=1 --delete-excluded'

echo 'Créé la structure de backup...'
ssh $TARGET_MACHINE mkdir -p $TARGET/full
ssh $TARGET_MACHINE mkdir -p $TARGET/$DIFF 

echo 'Backup via le rsync...'

RSYNC_CMD="rsync $SIMULATION $COMMAND $EXCLUDE --backup --backup-dir=$TARGET/$DIFF/ -e ssh $SOURCE $TARGET_MACHINE:$TARGET/full"
echo $RSYNC_CMD
/bin/bash -c "$RSYNC_CMD"

exit




#echo 'Set les bons privilèges sur la structure de backup'
#ssh $TARGET_MACHINE chown -R zuzu $TARGET
#ssh $TARGET_MACHINE chgrp -R users $TARGET

echo ""
echo -e ${GREEN}$0 "end...$(date)"${NOCOL}
echo ""

echo -e "

Si jamais pour info:
ssh-keygen
ssh-copy-id zulu@localhost
crontab -e
0 8-19/1 * * 1-5 /Users/zuzu/zlitebackup.sh (backup la journée du L-V)
0 20-6/2 * * * /Users/zuzu/zlitebackup.sh (backup la nuit tous les jours)
* * * * * /Users/zuzu/zlitebackup.sh (pour les tests)

"
