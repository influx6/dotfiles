#!/bin/bash

mkdir -p $HOME/.oh-my-zsh/themes
export OHMYZSH=$HOME/.oh-my-zsh
git clone https://github.com/romkatv/powerlevel10k.git $OHMYZSH/themes/powerlevel10k

mkdir -p $HOME/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $OHMYZSH/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OHMYZSH/custom/plugins/zsh-syntax-highlighting


mkdir -p $HOME/.tmux/plugins
export TMUX_DIR=$HOME/.tmux
git clone https://github.com/tmux-plugins/tpm $TMUX_DIR/plugins/tpm


