#!/usr/bin/env python2
# -*- coding: utf-8 -*-

# Petit utilitaire qui permet d'afficher le charset utilisé pour les noms de fichiers dans un dossier
# C'est très pratique pour déterminer pourquoi un rsync diff vois toujours un changement quand nous on ne voit rien
# christian@zufferey.com
# source: https://serverfault.com/questions/82821/how-to-tell-the-language-encoding-of-a-filename-on-linux

# pour installer la lib chardet il faut:
# sudo easy_install pip
# pip install chardet

version = "0.1.1 zf200329.2311"

print("zlscharset.py ver " + version)
import chardet
import os  

for n in os.listdir('.'):
    print '%s => %s (%s)' % (n, chardet.detect(n)['encoding'], chardet.detect(n)['confidence'])
