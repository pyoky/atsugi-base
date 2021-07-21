#!/bin/bash
cd $HOME
echo -e "- Download and run (d)"
echo -e "- Run only         (r)"
echo -e "- Upload profile   (u)"
echo -e "- Download vimrc   (v)"
echo -n "            Option: "
read OPTION
case $OPTION in
	d)
    rm -rf ~/.wine/ ~/aqua/
		wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz
		tar -xf gdrive_2.1.1_linux_386.tar.gz
		chmod +x ./gdrive
		./gdrive about
		./gdrive list
		./gdrive download 1RespoMBLqUoo1lIu9osm3HHYWRHgIXQK
		# FIXME: why is the second download so slow?
		./gdrive download 1nuDAWIF4JTVQFYa_a4WuJ00vB1qdegKg
		unzip mozilla.zip -d $HOME/
		chmod +x firefox.appimage
		# start, wait for few seconds, kill, then restart. 
		# This allows plugins to load 
		./firefox.appimage --appimage-extract-and-run &
		sleep 6
		kill -KILL $(pgrep firefox-bin | awk '{print $1 }')
		sleep 3
		./firefox.appimage --appimage-extract-and-run &
		;;

	r)
		./firefox.appimage --appimage-extract-and-run &
		;;
	u)
		cd $HOME
		rm mozilla.zip
		zip -r mozilla.zip .mozilla
		./gdrive update 1nuDAWIF4JTVQFYa_a4WuJ00vB1qdegKg mozilla.zip
		;;
  v)
    wget https://raw.githubusercontent.com/pyoky/ff/main/.vimrc
    ;;
	*)
		echo "unknown"
		;;
esac
