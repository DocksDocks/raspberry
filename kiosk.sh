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

printf "#!/bin/bash
xset s noblank
xset s off
xset -dpms

unclutter -root &

sed -i 's/\"exited_cleanly\":false/\"exited_cleanly\":true/' /home/\$USER/.config/chromium/Default/Preferences
sed -i 's/\"exit_type\":\"Crashed\"/\"exit_type\":\"Normal\"/' /home/\$USER/.config/chromium/Default/Preferences

/usr/bin/chromium --noerrdialogs --disable-infobars --kiosk https://pimylifeup.com https://www.adafruit.com &" > /home/pi/kiosk.sh

printf "[Unit]
Description=Chromium Kiosk
Wants=graphical.target
After=graphical.target

[Service]
Environment=DISPLAY=:0.0
Environment=XAUTHORITY=/home/pi/.Xauthority
Type=simple
ExecStart=/bin/bash /home/pi/kiosk.sh
Restart=on-abort
User=pi
Group=pi

[Install]
WantedBy=graphical.target" > /lib/systemd/system/kiosk.service

printf "#################################################
# LXDE-pi autostart script                      #
#                                               #   
# This file must be in the user's home e.g.     #
# /home/pi/.config/lxsession/LXDE-pi/autostart. #
#################################################

## enable/disable screen saver
#@xscreensaver -no-splash  # comment this line out to disable screensaver

# Set the current xsession not to blank out the screensaver and then disables the screensaver altogether.
@xset s noblank
@xset s off
# disables the display power management system
@xset -dpms

# Run the wanted app
@bash /home/pi/kiosk.sh" > /etc/xdg/lxsession/LXDE-pi/autostart

sudo chmod 750 /home/pi/kiosk.sh

sudo systemctl enable kiosk.service

echo "Starting..."

sudo systemctl start kiosk.service

