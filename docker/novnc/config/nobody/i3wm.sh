#!/bin/bash

set -x

enabled="$1"
DISPLAY="$2";

shift;
shift;

if [ "$enabled" = "1" ]; then
  if [ "$WINDOW_MANAGER" = "i3wm" ]; then
    dbus-launch i3 "$@"
  fi
fi

set +x
