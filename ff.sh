# TODO: add options for dl & open, open only, and upload
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
# FIXME: start and restart for loading extensions
./firefox.appimage --appimage-extract-and-run
