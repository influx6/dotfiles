#!/bin/bash

source ~/dotfiles/shell/functions

if no_command aider; then
    if has_command pip; then
        pip install aider-install
        aider-install
    fi
fi
