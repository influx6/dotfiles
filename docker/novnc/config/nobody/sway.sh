#!/bin/bash

set -x

enabled="$1"
DISPLAY="$2";

shift;
shift;

if [ "$enabled" = "1" ]; then
  if [ "$WINDOW_MANAGER" = "sway" ]; then
    dbus-launch sway
  fi
fi

set +x
