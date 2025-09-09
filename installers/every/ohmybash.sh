#!/bin/bash

source ~/dotfiles/shell/function

# install ohmybash
if no_dir $HOME/.oh-my-bash; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" >/dev/null
fi
