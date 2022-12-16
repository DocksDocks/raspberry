sudo apt install vlc

mkdir -p /home/pi/video/

cp video.mp4 /home/pi/video/video.mp4

filenameA=/etc/xdg/lxsession/LXDE-pi/autostart
if [ ! -f $filenameA ]
then
    touch $filenameA
fi

printf "@cvlc /home/pi/video/video.mp4 --fullscreen --loop --no-video-title-show --mouse-hide-timeout=0" > $filenameA 
