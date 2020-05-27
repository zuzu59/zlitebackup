#!/usr/bin/env bash

#BASH_XTRACEFD="5" && PS4='$LINENO: ' && set -e -v -x

#ssh-keygen
#ssh-copy-id zuzu@localhost

# ATENTION avec le nouveau file system d'Apple, APFS, les noms de fichiers ne sont plus en charset UTF8 mais ISO-8859-1
# et si la target est une clef USB non formatée en APFS, il va y avoir des problèmes de rsync diff avec les fichiers avec lettres accentuées !
# il faut donc formater la target USB en APFS si le MAC est en APFS
# si on n'arrive pas à formater une clef USB en APFS, il faut la prendre sous Linux et lui changer la device partition en 'gpt'
# puis après on peut la formater sur le MAC en APFS

echo -e "
Système de sauvegarde (backup) économique automatique de Full/Différentiel avec rsync et ssh
zf 1200711.1704,150209.0838,150625.2241, 161205.1115 200527.0923

Use: ./zlitebackup.sh

"

GREEN='\033[1;32m'
NOCOL='\033[0m'

echo -e ${GREEN}$0 "start...$(date)"${NOCOL}


###########################
# Paramètres à modifier ! #
###########################
# Simplement commenter la ligne SIMULATION pour ne plus simuler le backup !
#SIMULATION='-n'

SOURCE='/Users/zuzu'

#TARGET_MACHINE='root@ditsup-naszf2.epfl.ch'
TARGET_MACHINE="zuzu@localhost"

#TARGET='/volume1/zuzu/Backups/iMac-Zf'
TARGET="/Volumes/backupzf1/Backups/macbookprozf"


#EXCLUDE='--exclude=**/ImapMail/ --exclude=**/zlitebackup/ --exclude=**/*tmp* --exclude=**/.cache* --exclude=**/cache* --exclude=**/Cache* --exclude=**/lost+found* --exclude=**/*rash*  --exclude=**/mnt/* --exclude=**/.VirtualBox* --exclude=**/VirtualBox* --exclude=**/.evolution* --exclude=**/.mozilla* --exclude=**/.opera* --exclude=**/.macromedia* --exclude=**/.navicat* --exclude=**/google-earth* --exclude=**/.local/share/gvfs* --exclude=**/.thumbnails* --exclude=**/Picasa2/db3* --exclude=**/.gvfs* --exclude=**/.wine* --exclude=**/chromium/*'

#EXCLUDE='--exclude=**/Library* --exclude=**/mnt* --exclude=**/.Trash* --exclude=**/.atom* --exclude=**/.git* --exclude=**/.cisco* --exclude=**/*.photoslibrary* --exclude=**/VirtualBox?VM?Masters* --exclude=**/VirtualBox?VMs* --exclude=**/.vagrant.d/boxes*'

#EXCLUDE='--exclude=**/Library* --exclude=**/mnt* --exclude=**/.Trash* --exclude=**/ansible-deps-cache* --exclude=**/.atom* --exclude=**/.git* --exclude=**/.cisco* --exclude=**/*.photoslibrary* --exclude=**/VirtualBox?VM?Masters* --exclude=**/VirtualBox?VMs* --exclude=**/.vagrant.d/boxes*'

EXCLUDE='--exclude=**/Library* --exclude=**/mnt* --exclude=**/.Trash* --exclude=**/.DS_Store* --exclude=**/ansible-deps-cache* '
EXCLUDE=$EXCLUDE'--exclude=**/.atom* --exclude=**/.git* --exclude=**/.cisco* --exclude=**/*.photoslibrary* --exclude=**/VirtualBox?VM?Masters* '
EXCLUDE=$EXCLUDE'--exclude=**/VirtualBox?VMs* --exclude=**/.vagrant.d/boxes* --exclude=**/.android* --exclude=**/.gradle*'




###########################
echo -e "
Snapshot des noms des fichiers à sauvegarder pour un full restore à un moment t...
Pour le voir: 
gzip -d -c ~/list_files.gz |less
"

find $SOURCE 2> /dev/null |grep -v -e '/Library/' -e '/mnt/' -e '/.Trash/' -e '/.atom/' -e '/.git/' -e '/Media.localized/' -e ' Library.'  -e '.localized/' -e '/ansible-deps-cache/' |gzip > ~/list_files.gz
echo -e ""


echo -e "\nScripts qui tournent AVANT le zlitebackup...\n"
~/zlitebackup/zcopy_atom_config.sh
~/zlitebackup/zcopy_keybase_pub_backup.sh
echo -e ""

YEAR=`date +%Y` 
MONTH=`date +%m`
DAY=`date +%d`
TIME=`date +%H-%M-%S` 
DIFF='diff/'${YEAR}/${MONTH}/${DAY}/${TIME}

COMMAND='-l -i -r -t -v --progress --stats --modify-window=1 --delete-excluded'
#COMMAND='-i -r -t -v --progress --stats --modify-window=1 --delete-excluded'
#COMMAND='-i -r -t -v --progress --stats --size-only --modify-window=1 --delete-excluded'
#COMMAND='-i -r -t -v --progress --stats --checksum --modify-window=1 --delete-excluded'

#COMMAND='-r -t -v --progress --stats --size-only --modify-window=1 --delete-excluded'
#COMMAND='-r -t -v --progress --stats --checksum --modify-window=1 --delete-excluded'

echo -e "Créé la structure de backup...\n"
ssh $TARGET_MACHINE mkdir -p $TARGET/full
ssh $TARGET_MACHINE mkdir -p $TARGET/$DIFF 

echo -e "Backup via le rsync...\n"

RSYNC_CMD="rsync $SIMULATION $COMMAND $EXCLUDE --backup --backup-dir=$TARGET/$DIFF/ -e ssh $SOURCE $TARGET_MACHINE:$TARGET/full"
echo $RSYNC_CMD
echo ""
/bin/bash -c "$RSYNC_CMD"

#echo 'Set les bons privilèges sur la structure de backup'
#ssh $TARGET_MACHINE chown -R zuzu $TARGET
#ssh $TARGET_MACHINE chgrp -R users $TARGET

echo ""
echo -e ${GREEN}$0 "end...$(date)"${NOCOL}
echo ""

echo -e "

Si jamais pour info:

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
ssh-copy-id zuzu@localhost

crontab -e
0 8-19/1 * * 1-5 /Users/zuzu/zlitebackup.sh (backup la journée du L-V)
0 20-6/2 * * * /Users/zuzu/zlitebackup.sh (backup la nuit tous les jours)
* * * * * /Users/zuzu/zlitebackup.sh (pour les tests)

"
