#!/bin/bash

enabled="$1"
DISPLAY="$2";

shift;
shift;

if [ "$enabled" = "1" ]; then
  copyq "$@"
fi
