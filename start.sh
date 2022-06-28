#!/usr/bin/env bash
# Fichier de lancement pour mes différents zlitebackup 
# zf220628.0736


#BASH_XTRACEFD="5" && PS4='$LINENO: ' && set -e -v -x

GREEN='\033[1;32m'
NOCOL='\033[0m'

echo -e ${GREEN}$0 "start full zlitebackup...$(date)"${NOCOL}

./zlitebackup.sh
./famillez_zlitebackup.sh

echo ""
echo -e ${GREEN}$0 "end full zlitebackup...$(date)"${NOCOL}
echo ""

