#!/bin/bash
cd $HOME
#echo -e "- Download and run (d)"
#echo -e "- Run only         (r)"
#echo -e "- Upload profile   (u)"
#echo -e "- Download vimrc   (v)"
#echo -n "            Option: "
#read OPTION

Help()
{
  # Display Help
  echo "Usage: (-h|d|r|u|v)"
}

Download()
{
  rm -rf ~/.wine/ ~/aqua/
	wget https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz
 	tar -xf gdrive_2.1.1_linux_386.tar.gz
  kill -KILL $(pgrep Hamoni | awk '{print $1 }')
 	chmod +x ./gdrive
  ./gdrive about | tee >(egrep -o -m 1 'https?://[^ ]+' | xargs xdg-open > /dev/null 2>&1)
 	./gdrive list
 	./gdrive download 1RespoMBLqUoo1lIu9osm3HHYWRHgIXQK
 	# FIXME: why is the second download so slow?
 	./gdrive download 1nuDAWIF4JTVQFYa_a4WuJ00vB1qdegKg
 	unzip mozilla.zip -d $HOME/
 	chmod +x ff.appimage
 	# start, wait for few seconds, kill, then restart. 
 	# This allows plugins to load 
	nohup ./ff.appimage --appimage-extract-and-run > /dev/null 2>&1 &
 	sleep 6
 	kill -KILL $(pgrep ff-bin | awk '{print $1 }')
 	sleep 3
	nohup ./ff.appimage --appimage-extract-and-run > /dev/null 2>&1 &
}

while getopts ":hdruvx:" OPTION; do
  case $OPTION in
    h) # display help
      Help
      ;;
  	d)
      Download
  		;;
  	r)
		nohup ./ff.appimage --appimage-extract-and-run > /dev/null 2>&1 &
  		;;
  	u)
  		cd $HOME
  		rm mozilla.zip
  		zip -r mozilla.zip .mozilla
  		./gdrive update 1nuDAWIF4JTVQFYa_a4WuJ00vB1qdegKg mozilla.zip
  		;;
    v)
      wget https://raw.githubusercontent.com/pyoky/ff/main/.vimrc
      echo "Downloaded to ~/.vimrc"
      ;;
    x)
      xrandr --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
      xrandr --addmode DP-3 1680x1050_60.00
      echo "Display resolution will change now"
      wait 3
      xrandr -s 1680x1050
      ;;
  	\?)
      echo "Use with -h to show list of options"
      ;;
  esac
done
