sudo apt install vlc

filename=/home/pi/launcher.sh
if [ ! -f $filename ]
then
    touch $filename
fi

mkdir -p /home/pi/video/

cp video.mp4 /home/pi/video/video.mp4

printf "#!/bin/bash
sleep 1
cvlc /home/pi/video/video.mp4 --fullscreen --loop --no-video-title-show" > $filename


filenameA=/etc/xdg/lxsession/LXDE-pi/autostart
if [ ! -f $filenameA ]
then
    touch $filenameA
fi

printf "@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
@xscreensaver -no-splash
@bash $filename" > $filenameA 
