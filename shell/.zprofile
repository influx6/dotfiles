
export PATH="$PATH:$HOME/.rvm/bin"
export Dotfiles=$HOME/dotfiles

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
[[ ! -f /opt/homebrew/bin/brew ]] ||  eval "$(/opt/homebrew/bin/brew shellenv)"

# add linuxbrew to the PATH
export PATH=$PATH:$HOME/Devlabs/pkg/go/bin:$HOME/go/bin:$HOME/Devlabs/appImages

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

## restore quiet mode when set -x is on
##set +x

. "$HOME/.cargo/env"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

set +o noclobber


# Added by OrbStack: command-line tools and integration
[[ ! -f ~/.orbstack/shell/init.zsh ]] ||  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
