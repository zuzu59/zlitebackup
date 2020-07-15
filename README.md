# zlitebackup
Petit système de sauvegarde (backup) économique automatique de Full/Différentiel avec rsync et ssh

zf1200711.1704,150209.0838,150625.2241,161205.1115,    200501.1543

ATENTION avec le nouveau *file system* d'Apple, *APFS*, les noms de fichiers ne sont plus en charset UTF8 mais ISO-8859-1
et si la *target* est une clef USB non formatée en APFS, il va y avoir des problèmes de *rsync diff* avec les fichiers avec lettres accentuées !

Il faut donc formater la *target* USB en APFS si le MAC est en APFS

Si on n'arrive pas à formater une clef USB en APFS, il faut la prendre sous Linux et lui changer la *device partition* en *gpt*
puis après on peut la formater sur le MAC en APFS.





.
