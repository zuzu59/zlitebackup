#!/usr/bin/env bash
# Petit script pour copier la configuration de l'éditeur Atom dans un dossier de l'utilisateur 
# car le dossier .atom où se trouve la configuration n'est pas sauvegardé par zlitebackup
# zf200526.1837

mkdir ~/atom_config_zlitebackup/
cp -p ~/.atom/*.cson ~/atom_config_zlitebackup/
