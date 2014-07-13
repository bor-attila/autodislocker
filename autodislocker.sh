#!/bin/bash
password=XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX
tmpdir=/mnt/tmp
mdir=/mnt/usb
device=sdb
umon=false
usingfile=false

if [ $(ls -l /usr/bin/ | grep dislocker | wc -l) = 0 ]; then
	echo "ERROR: Dislocker not found!"
	exit 1;
fi;

if [ $(whoami) != 'root' ]; then
	echo "ERROR : You must be logged in as root!";
	exit 1;
fi; 

if [ $(cat /etc/*-release | grep Ubuntu | wc -l) -gt 0 ]; then
	tmpdir=/media/tmp
	mdir=/media/usb
fi;

while getopts "uf:p:d:" OPTION; do
     case $OPTION in
         u)
             umon=true
             ;;
         f)
             usingfile=$OPTARG
             ;;
         p)
             password=$OPTARG
             ;;
         d)
             device=$OPTARG
             ;;
         ?)
             echo "WARN: Invalid argument!"
             exit
             ;;
     esac
done


if [ "$umon" = true ]; then
	echo "Unmounting ..."
	umount -f $mdir
	umount -f $tmpdir	
	if [ $? ]; then 
		echo "Done."
		exit 0;
	fi;
	exit 1;
fi;

if [ ! -b /dev/$device ]; then
	echo "ERROR : The /dev/$device is not a block device!";
	exit 1;
fi;

if [ ! -d $tmpdir ]; then
	echo "NOTICE : Creating $tmpdir ....";
	mkdir $tmpdir
fi;

if [ ! -d $mdir ]; then
	echo "NOTICE : Creating $mdir ....";
	mkdir $mdir
fi;

if [ "$usingfile" = false ]; 
then
	dislocker -q -V /dev/$device -p$password -- $tmpdir
else
	dislocker -q -V /dev/$device -f$password -- $tmpdir
fi;

if [ $? != 0 ]; then
	echo "ERROR: Mount failed!";
	exit 1;
fi;

mount -o nonempty,loop,ro $tmpdir/dislocker-file $mdir
