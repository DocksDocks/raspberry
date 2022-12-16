sudo apt-get -y update
sudo apt-get -y dist-upgrade
sudo apt-get install -y omxplayer #(this can take about 10 minutes..)
sudo apt-get install -y screen

filename=/etc/init.d/videoloop
if [ ! -f $filename ]
then
    touch $filename
fi

cp video.mp4 /boot/video.mp4

printf '#!/bin/bash
### BEGIN INIT INFO
# Provides: omxplayer
# Required-Start:
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Displays video file in a loop using omxplayer
# Description:
### END INIT INFO

# Video (replace with the path and file name of your video)
video_path=/boot/video.mp4

#---- There should be no need to edit anything below this line ----

# Start displaying the video loop
case "$1" in start)
screen -dmS videoloop sh -c "omxplayer -o both $video_path -b --loop --no-osd"
echo "Video Playback Started"
;;

# Stop displaying video loop
stop)
sudo killall omxplayer.bin
echo "Video Playback Stopped"
;;

# Restart video loop if it died
repair)
if !(ps -a | grep omx -q)
    then
    screen -dmS videoloop sh -c "omxplayer -o local $video_path -b --loop --no-osd"
    echo "The Video is now running"
fi
;;

*)

echo "Usage: /etc/init.d/videoloop {start|stop|repair}"

exit 1

;;
esac' > $filename

sudo chmod 755 $filename

sudo update-rc.d videoloop defaults