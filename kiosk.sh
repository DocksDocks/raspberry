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
### Use unclutter to hide the mouse
unclutter -root &
### These two lines of the script use sed to search through the Chromium preferences file and clear out any flags that would make the warning bar appear, a behavior you don’t really want happening on your Raspberry Pi Kiosk
#sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
#sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

### This line launches Chromium with our parameters. We will go through each of these parameters so you know what you can modify, and how you can modify it.
### --kiosk : operate in kiosk mode (limited acces to browser and OS e.g. no system bar, no tabs)
### --noerrdialogs : do not show error dialogs
### --disable-infobars : disable info bar (e.g. "chroium is not de default browser")
### --start-fullscreen (not necessary in kiosk mode)
### --incognito

chromium-browser --noerrdialogs --disable-infobars --kiosk http://youtube.com &

# You may want to enclose the btowser command in a *while loop* to reopen the browser when user closes it instead of closing x server.
# In this case add an `&` at the end of the browser line:
#
#while true; do
#chromium-browser --noerrdialogs --disable-infobars --incognito --kiosk http://localhost:8080/&
#done" > /home/pi/kiosk.sh

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

