#!/usr/bin/env bash
# Petit script pour copier la configuration de l'éditeur Atom dans un dossier de l'utilisateur 
# car le dossier .atom où se trouve la configuration n'est pas sauvegardé par zlitebackup
# zf200526.1840

mkdir ~/keybase_pub_backup/
cp -p -R /keybase/team/epfl_idevfsd.apprentis* ~/keybase_pub_backup/
cp -p -R /keybase/team/epfl_dojo* ~/keybase_pub_backup/
cp -p -R /keybase/team/msl_* ~/keybase_pub_backup/
