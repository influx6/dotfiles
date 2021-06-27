# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash

## see whats causing slow execution
##set -x

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

## restore quiet mode when set -x is on
## set +x
if [ -e /home/darkstar/.nix-profile/etc/profile.d/nix.sh ]; then . /home/darkstar/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export PATH=$HOME/Devlabs/pkg/kafka_2.12-2.7.0/bin:$PATH
_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
. "$HOME/.cargo/env"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"