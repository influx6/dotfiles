#!/bin/bash

enabled="$1"
DISPLAY="$2";

shift;
shift;

if [ "$enabled" = "1" ]; then
  autocutsel -debug "$@"
fi
