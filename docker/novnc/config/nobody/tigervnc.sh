#!/bin/bash

set -x

rm -rf /tmp/.X*;

source /home/novnc/tigervnc_base.sh

VNC_SERVER="$1";
enabled="$2";
display="$3"
display_port="$4"

shift;
shift;
shift;
shift;

if [ "${VNC_SERVER}" = "tigervnc" ]; then
  if [ "${enabled}" = "1" ]; then
    echo "Creating screen for display $display";
    screen1=$(create_screen "$display" "$display_port" "$@")
    echo "executing command: ${screen1}";
    eval "$screen1";
  fi
fi


set +x
