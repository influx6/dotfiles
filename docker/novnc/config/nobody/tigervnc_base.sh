#!/bin/bash

rm -rf /tmp/.X*;
mkdir -p /var/screens

# setup env for user nobody
OTHER_ARGS="-SecurityTypes=${SECURITY_TYPE} -X509Cert /home/novnc/ssl/server.crt -X509Key /home/novnc/ssl/server.key"

if [ -f "/home/novnc/.vnc/passwd" ]; then
  OTHER_ARGS="-SecurityTypes=${SECURITY_TYPE} -PasswordFile /home/novnc/.vnc/passwd -X509Cert /home/novnc/ssl/server.crt -X509Key /home/novnc/ssl/server.key"
fi

create_screen() {
  DISPLAY="$1";
  display="$1";
  port="$2"

  shift;
  shift;

  other_args="$@";

  command="";
  if [ "${DISPLAY_MAX}" = "1" ]; then
    command="Xvnc ${display} -rfbport ${port} -geometry ${DISPLAY_WIDTH_MAX}x${DISPLAY_HEIGHT_MAX} -depth ${DISPLAY_DEPTH} -pixelformat ${DISPLAY_PIXEL_FORMAT} -FrameRate=${VNC_FRAMERATE} ${OTHER_ARGS} ${other_args}"
  else
    command="Xvnc ${display} -rfbport ${port} -geometry ${DISPLAY_WIDTH}x${DISPLAY_HEIGHT} -depth ${DISPLAY_DEPTH} -pixelformat ${DISPLAY_PIXEL_FORMAT} -FrameRate=${VNC_FRAMERATE} ${OTHER_ARGS} ${other_args}"
  fi

  echo "$command"
}
