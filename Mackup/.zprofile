
export PATH="$PATH:$HOME/.rvm/bin"
export Dotfiles=$HOME/dotfiles

export EDITOR='vim'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'


export SDKMAN_DIR="$HOME/.sdkman"
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.cargo/bin:$HOME/dotfiles/bin:$PATH"
export PATH=$HOME/apache-tomcat-7.0.104/bin:$PATH
export PATH=/snap/bin:$HOME/.local/bin:$HOME/Devlabs/bin:$PATH
export PATH=$HOME/apache-tomcat-7.0.104/bin:$HOME/apache-tomcat-7.0.105/bin:$PATH

[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [ -e $HOME/.profile.custom ]; then . $HOME/.profile.custom; fi # load .profile.custom
if [ -e $HOME/.profile.prive ]; then . $HOME/.profile.prive; fi # load .profile.custom
if [ -e $HOME/.profile.prive.ci ]; then . $HOME/.profile.prive.ci; fi # load .profile.custom
if [ -e $HOME/.profile.prive.aws ]; then . $HOME/.profile.prive.aws; fi # load .profile.custom
if [ -e $HOME/.profile.firebase ]; then . $HOME/.profile.firebase; fi # load .profile.custom
if [ -e $HOME/.profile.git ]; then . $HOME/.profile.git; fi # load .profile.custom
if [ -e $HOME/.profile.linode ]; then . $HOME/.profile.linode; fi # load .profile.custom

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval "$(/opt/homebrew/bin/brew shellenv)"

source $Dotfiles/Mackup/config

# add linuxbrew to the PATH
export PATH=$PATH:$HOME/Devlabs/pkg/go/bin:$HOME/go/bin:$HOME/Devlabs/appImages

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

## restore quiet mode when set -x is on
##set +x


export PATH=$PATH:$HOME/Devlabs/pkg/Flutter/flutter/bin:opt/net.downloadhelper.coapp/bin/

set +o noclobber
. "$HOME/.cargo/env"