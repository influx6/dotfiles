#!/bin/bash

# install deno
if no_command deno; then
  curl -fsSL https://deno.land/x/install/install.sh | sh
fi
