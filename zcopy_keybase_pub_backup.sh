#!/usr/bin/env bash
# Petit script pour copier la configuration de l'éditeur Atom dans un dossier de l'utilisateur 
# car le dossier .atom où se trouve la configuration n'est pas sauvegardé par zlitebackup
# zf200527.0753

echo -e "zcopy_keybase_pub_backup.sh" 

mkdir ~/keybase_pub_backup/ 2> /dev/null

rsync -n -l --delete -r -t /keybase/team/epfl_idevfsd.apprentis* ~/keybase_pub_backup/
rsync -n -l --delete -r -t /keybase/team/epfl_dojo* ~/keybase_pub_backup/
rsync -n -l --delete -r -t /keybase/team/msl_* ~/keybase_pub_backup/
