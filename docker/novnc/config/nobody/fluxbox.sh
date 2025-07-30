#!/bin/bash

set -x

enabled="$1"
DISPLAY="$2";

shift;
shift;

if [ "$enabled" = "1" ]; then
  if [ "$WINDOW_MANAGER" = "fluxbox" ]; then
    dbus-launch fluxbox "$@"
  fi
fi

set +x
