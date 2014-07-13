Autodislocker
=============

Mount BitLocker encrypted partitions under Linux.


0.) Download and install dislocker for linux ( http://www.hsc.fr/ressources/outils/dislocker/ )

1.) Change the "password" (recovery passsword) variable. (second line - this will be your default password)

2.) Mount your drive : sudo sh autodislocker.sh 


Arguments
---------

Use non-default password:

- sudo sh autodislocker.sh -p XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX

Use .bek file:

- sudo sh autodislocker.sh -f /path/to/bek/file.bek

Unmount:

- sudo sh autodislocker.sh -u

The default block device is sdb! If you want to use sdX you can use the -d command line argument.

- sudo sh autodislocker.sh -d sdX
