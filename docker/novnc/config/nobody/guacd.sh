#!/bin/bash

set -x

if [ "${GUACA_SSL}" = "true" ]; then
  guacd -f -l 5111 -b localhost -L debug -C /home/novnc/ssl/server.crt -K /home/novnc/ssl/server.key
else
  guacd -f -l 5111 -b localhost -L debug
fi


set +x
