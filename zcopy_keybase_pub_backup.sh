#!/usr/bin/env bash
# Petit script pour copier quelques fichiers de keybase  
# car le dossier /keybase où se trouvent les fichiers n'est pas sauvegardé par zlitebackup
# zf200527.0753, zf220218.0916

echo -e "zcopy_keybase_pub_backup.sh" 

mkdir ~/keybase_pub_backup/ 2> /dev/null

rsync -l --delete -r -t /keybase/team/epfl_idevfsd.apprentis* ~/keybase_pub_backup/
rsync -l --delete -r -t /keybase/team/epfl_dojo* ~/keybase_pub_backup/
rsync -l --delete -r -t /keybase/team/epfl_sdf* ~/keybase_pub_backup/
rsync -l --delete -r -t /keybase/team/msl_* ~/keybase_pub_backup/
