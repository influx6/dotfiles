#!/bin/bash

set -x

enabled="$1"
DISPLAY="$2";

shift;
shift;

if [ "$enabled" = "1" ]; then
  vncconfig -iconic --nowin -display "$DISPLAY" "$@"
fi

set +x
