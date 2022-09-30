#!/bin/sh

sudo apt install -y xdotool unclutter sed

filename=/home/pi/kiosk.sh
if [ ! -f $filename ]
then
    touch $filename
fi

filenameS=/lib/systemd/system/kiosk.service
if [ ! -f $filenameS ]
then
    touch $filenameS
fi

filenameT=/etc/xdg/lxsession/LXDE-pi/autostart
if [ ! -f $filenameT ]
then
    touch $filenameT
fi
filenameM=/home/pi/hideMouse.sh
if [ ! -f $filenameM ]
then
    touch $filenameM
fi

printf "#!/bin/bash
xset s noblank
xset s off
xset -dpms

sed -i 's/\"exited_cleanly\":false/\"exited_cleanly\":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/\"exit_type\":\"Crashed\"/\"exit_type\":\"Normal\"/' /home/pi/.config/chromium/Default/Preferences" > /home/pi/kiosk.sh

printf"#!/bin/bash
unclutter -idle 0.5 -root &" > /home/pi/hideMouse.sh

printf "[Unit]
Description=Chromium Kiosk
Wants=graphical.target
After=graphical.target

[Service]
Environment=DISPLAY=:0.0
Environment=XAUTHORITY=/home/pi/.Xauthority
Type=simple
ExecStartPre=/home/pi/kiosk.sh
ExecStart=/usr/bin/chromium --noerrdialogs --disable-infobars --kiosk http://youtube.com
Restart=on-abort
User=pi
Group=pi

[Install]
WantedBy=graphical.target" > /lib/systemd/system/kiosk.service

printf "
# Run the wanted app
@bash /home/pi/hideMouse.sh" > /etc/xdg/lxsession/LXDE-pi/autostart

sudo chmod 750 /home/pi/kiosk.sh

sudo systemctl enable kiosk.service

echo "Starting..."

