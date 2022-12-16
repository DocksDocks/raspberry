sudo apt install vlc

mkdir -p /home/pi/video/

cp video.mp4 /home/pi/video/video.mp4

filenameA=/etc/systemd/system/videokiosk.service
if [ ! -f $filenameA ]
then
    touch $filenameA
fi

printf "[Unit]
Description=videokiosk

[Service]
User=pi
Environment="DISPLAY=:0"
ExecStart=cvlc /home/pi/video/video.mp4 --fullscreen --loop --no-video-title-show
WorkingDirectory=/home/pi
Restart=always

[Install]
WantedBy=multi-user.target" > $filenameA 


echo "#
#
#
NOW type this in your console:
~ sudo systemctl enable videokiosk.service 
and then this:
~ sudo systemctl start videokiosk.service
#
#"
