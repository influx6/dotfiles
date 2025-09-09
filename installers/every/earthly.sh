#!/bin/bash
source ~/dotfiles/shell/functions

# install earhly ci
if no_command earthly 2>&1 >/dev/null; then
  mkdir -p "$HOME/.local/bin"
  wget https://github.com/earthly/earthly/releases/latest/download/earthly-linux-amd64 -O $HOME/.local/bin/earthly &&
    chmod +x $HOME/.local/bin/earthly &&
    $HOME/.local/bin/earthly bootstrap --with-autocomplete
fi
