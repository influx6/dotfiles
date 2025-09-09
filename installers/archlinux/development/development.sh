#!/bin/bash

source ~/dotfiles/shell/functions
source ~/dotfiles/installers/every/brew.sh

yay -S --noconfirm --needed \
  cargo clang llvm mise \
  imagemagick \
  mariadb-libs postgresql-libs \
  github-cli \
  lazygit lazydocker-bin


# # install github sync
# if no_dir $HOME/.github-org-sync; then
#   git clone https://github.com/oxzi/github-orga-sync ~/.github-org-sync && cd ~/.github-org-sync && go install && cd -
# fi

# install go (brew is required)
if no_command go && has_command brew; then
  brew install go
fi

# install mise
if no_command mise; then
  curl https://mise.run | sh
fi

if has_command mise; then
  mise install python@3.8.9
  mise install python@3.9.0
  mise install python@3.10.0
  mise install python@3.11.8
  mise install python@3.12.10
fi
