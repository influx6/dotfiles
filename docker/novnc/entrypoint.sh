#!/bin/bash

# Xvfb :0 -screen 0 1024x768x24 &

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#@                                                           @#
#@  **  WARNING  **  WARNING  **  WARNING  **  WARNING  **   @#
#@                                                           @#
#@        YOU ARE RUNNING X11VNC WITHOUT A PASSWORD!!        @#
#@                                                           @#
#@  This means anyone with network access to this computer   @#
#@  may be able to view and control your desktop.            @#
#@                                                           @#
#@ >>> If you did not mean to do this Press CTRL-C now!! <<< @#
#@                                                           @#
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#@                                                           @#
#@  You can create an x11vnc password file by running:       @#
#@                                                           @#
#@       x11vnc -storepasswd password /path/to/passfile      @#
#@  or   x11vnc -storepasswd /path/to/passfile               @#
#@  or   x11vnc -storepasswd                                 @#
#@                                                           @#
#@  (the last one will use ~/.vnc/passwd)                    @#
#@                                                           @#
#@  and then starting x11vnc via:                            @#
#@                                                           @#
#@      x11vnc -rfbauth /path/to/passfile                    @#
#@                                                           @#
#@  an existing ~/.vnc/passwd file from another VNC          @#
#@  application will work fine too.                          @#
#@                                                           @#
#@  You can also use the -passwdfile or -passwd options.     @#
#@  (note -passwd is unsafe if local users are not trusted)  @#
#@                                                           @#
#@  Make sure any -rfbauth and -passwdfile password files    @#
#@  cannot be read by untrusted users.                       @#
#@                                                           @#
#@  Use x11vnc -usepw to automatically use your              @#
#@  ~/.vnc/passwd or ~/.vnc/passwdfile password files.       @#
#@  (and prompt you to create ~/.vnc/passwd if neither       @#
#@  file exists.)  Under -usepw, x11vnc will exit if it      @#
#@  cannot find a password to use.                           @#
#@                                                           @#
#@                                                           @#
#@  Even with a password, the subsequent VNC traffic is      @#
#@  sent in the clear.  Consider tunnelling via ssh(1):      @#
#@                                                           @#
#@    http://www.karlrunge.com/x11vnc/#tunnelling            @#
#@                                                           @#
#@  Or using the x11vnc SSL options: -ssl and -stunnel       @#
#@                                                           @#
#@  Please Read the documention for more info about          @#
#@  passwords, security, and encryption.                     @#
#@                                                           @#
#@    http://www.karlrunge.com/x11vnc/faq.html#faq-passwd    @#
#@                                                           @#
#@  To disable this warning use the -nopw option, or put     @#
#@  'nopw' on a line in your ~/.x11vncrc file.               @#
#@                                                           @#
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
###############################################################

#sudo chown -R $PUID:$GUID /home/nobody/.idea
#sudo chown  $PUID:$GUID /home/nobody/Lab

#echo "${PUID} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
#echo "%${GUID} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# /etc/password: darkvoid:x:1000:1000:Alexander:/home/darkvoid:/bin/bash
env

sudo groupmod -g $GUID novnc
sudo usermod -u $PUID novnc

# set localtime
sudo cp /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" | sudo tee /etc/timezone

date

# set password for tigervnc/Xvnc
echo -e "${VNC_PASSWORD}\n${VNC_PASSWORD}\nn" | vncpasswd 1>&- 2>&-

export PYTHONPATH="$HOME/.cache/pip:$PYTHONPATH"
export PATH="$HOME/.cache/pip/bin:$PATH"

eval $(ssh-agent)
if [ -d /home/novnc/.ssh/ ]; then
  sudo chown -R $PUID:$GUID "/home/novnc/.ssh"
fi

if [ -f /home/novnc/.ssh/id_rsa ]; then
  ssh-add /home/novnc/.ssh/id_rsa
  sudo chown -R $PUID:$GUID "/home/novnc/.ssh"
fi

# set password for x11vnc
sudo -H -u novnc x11vnc -storepasswd "${VNC_PASSWORD}" /home/novnc/x11_password

if [ "$GUACAMOLE_SETUP" = "1" ]; then
  # replace guacamole password with updated values in usermapping
  guaca_password=$(echo -n "${GUACA_PASSWORD}" | md5sum |  cut -d' ' -f1)
  echo "Guaca password: ${guaca_password}"

  sed -i -e "s/{{GUACA_PASSWORD}}/${guaca_password}/g" /home/novnc/guacamole/user-mapping.xml
  sed -i -e "s/{{VNC_PASSWORD}}/${VNC_PASSWORD}/g" /home/novnc/guacamole/user-mapping.xml
  sed -i -e "s/{{GUACA_SSL}}/${GUACA_SSL}/g" /home/novnc/guacamole/guacamole.properties
fi

sudo rc-status
sudo rc-service dbus start;
sudo rc-service elogind start;
sudo rc-service sshd start
sudo rc-status

# start application
/usr/bin/supervisord -c /etc/supervisord.conf