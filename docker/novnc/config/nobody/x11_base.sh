#!/bin/bash

rm -rf /tmp/.X*;
rm -rf /var/tmp/.X*;

create_screen() {
  display="$1";
  screen="$2";
  size="$3";

  shift;
  shift;
  shift;

  opts="$@";

  # setup env for user nobody
  echo "Xvfb ${display} -noreset -screen ${screen} ${size} ${opts}"
}
