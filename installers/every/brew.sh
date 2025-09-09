#!/bin/bash


# install homebrew
if no_command brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -d $HOME/linuxbrew ]; then
    eval "$($HOME/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi
