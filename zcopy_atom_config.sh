#!/usr/bin/env bash
# Petit script pour copier la configuration de l'éditeur Atom dans un dossier de l'utilisateur 
# car le dossier .atom où se trouve la configuration n'est pas sauvegardé par zlitebackup
# zf200527.0753

echo -e "zcopy_atom_config.sh" 
mkdir ~/atom_config_zlitebackup/ 2> /dev/null
rsync -n -l --delete -r -t ~/.atom/*.cson ~/atom_config_zlitebackup/
