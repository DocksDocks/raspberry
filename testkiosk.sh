sudo apt-get install -y --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox
sudo apt-get install -y --no-install-recommends chromium-browser

filenameA=/etc/xdg/openbox/autostart
if [ ! -f $filenameA ]
then
    touch $filenameA
fi

filenameS=/etc/xdg/openbox/environment
if [ ! -f $filenameE ]
then
    touch $filenameE
fi

filenameB=/home/pi/.profile
if [ ! -f $filenameB ]
then
    touch $filenameB
fi

KIOSK_URL=https://desertbot.io

printf "xset -dpms            # turn off display power management system
xset s noblank        # turn off screen blanking
xset s off            # turn off screen saver
# Remove exit errors from the config files that could trigger a warning

sed -i 's/\"exited_cleanly\":false/\"exited_cleanly\":true/' ~/.config/chromium/'Local State'

sed -i 's/\"exited_cleanly\":false/\"exited_cleanly\":true/; s/\"exit_type\":\"[^\"]\+\"/\"exit_type\":\"Normal\"/' ~/.config/chromium/Default/Preferences

# Run Chromium in kiosk mode
chromium-browser  --noerrdialogs --disable-infobars --kiosk --check-for-update-interval=31536000 $KIOSK_URL
" > $filenameA

printf "#!bin/sh
[[ -z \$DISPLAY && \$XDG_VTNR -eq 1 ]] && startx -- -nocursor" >> $filenameB

echo "type:\n source ~/.bash_profile \nand then:\n sudo reboot"
