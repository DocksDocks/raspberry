#!/bin/sh

sudo apt purge wolfram-engine scratch scratch2 nuscratch sonic-pi idle3 -y
sudo apt purge smartsim java-common minecraft-pi libreoffice* -y
sudo apt clean
sudo apt autoremove -y
sudo apt update
sudo apt upgrade
sudo apt install xdotool unclutter sed

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
printf "
#!/bin/bash
xset s noblank
xset s off
xset -dpms

unclutter -root &

sed -i 's/\"exited_cleanly\":false/\"exited_cleanly\":true/' /home/$USER/.config/chromium/Default/Preferences
sed -i 's/\"exit_type\":\"Crashed\"/\"exit_type\":\"Normal\"/' /home/$USER/.config/chromium/Default/Preferences

/usr/bin/chromium --noerrdialogs --disable-infobars --kiosk https://youtube.com &" > /home/pi/kiosk.sh && \
chmod u+x /home/pi/kiosk.sh && \
printf "
[Unit]
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
WantedBy=graphical.target" > /lib/systemd/system/kiosk.service && \
sudo systemctl enable kiosk.service && \
echo "Starting..." && \
sudo systemctl start kiosk.service

