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
 	./ff.appimage --appimage-extract-and-run &
 	sleep 6
 	kill -KILL $(pgrep ff-bin | awk '{print $1 }')
 	sleep 3
 	./ff.appimage --appimage-extract-and-run &
}

while getopts ":hdruv:" OPTION; do
  case $OPTION in
    h) # display help
      Help
      exit;;
  	d)
      Download
  		exit;;
  
  	r)
  		./ff.appimage --appimage-extract-and-run &
  		exit;;
  	u)
  		cd $HOME
  		rm mozilla.zip
  		zip -r mozilla.zip .mozilla
  		./gdrive update 1nuDAWIF4JTVQFYa_a4WuJ00vB1qdegKg mozilla.zip
  		exit;;
    v)
      wget https://raw.githubusercontent.com/pyoky/ff/main/.vimrc
      exit;;
    c)
      exit;;
  	\?)
      echo "Use with -h to show list of options"
      exit;;
  esac
done
Help
