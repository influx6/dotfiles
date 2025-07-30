#!/bin/bash

set -x


(echo novnc; echo novnc) | passwd root

# add user "novnc" to primary group "users" (will remove any other group membership)
addgroup -g 1001 sudo
addgroup -g 1002 users

addgroup -g "$GUID" novnc

# setup env for user novnc
mkdir -p '/home/novnc'
adduser -D -G novnc -u "$PUID" -s /bin/bash --home /home/novnc novnc
(echo novnc; echo novnc) | passwd novnc

# add user "novnc" to secondary group "novnc" (will retain primary membership)
adduser novnc novnc
adduser novnc users
adduser novnc sudo
adduser novnc video
adduser novnc input

chown novnc:novnc /home/novnc

# change permission of folders
chown -R root:users /tmp/
chown -R root:users /var/
chown -R root:users /etc/

echo "$TZ" > /etc/timezone

chmod 0775 /etc/timezone
chmod 0775 /etc/localtime

# set shell for user novnc
export HOME=/home/novnc

# setup tomcat
sudo mkdir /run/openrc
sudo touch /run/openrc/softlevel

sudo mkdir -p /var/screens
sudo chmod 0777 -R /var/screens

dbus-uuidgen > /var/lib/dbus/machine-id

rc-update add dbus

setup-xorg-base
setup-udev

set +x