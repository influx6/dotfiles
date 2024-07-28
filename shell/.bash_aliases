alias edit_aliases="vim ~/.bash_aliases"
alias edit_profile="vim ~/.profile"
alias edit_bash="vim ~/.bashrc"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# multipass
alias mpass="multipass"
alias mp="multipass"

# docker
alias dok="docker"

# k8s, microk8s
alias k="kubectl"
alias ms="microk8s"
alias msk="microk8s.kubectl"

# git
alias g="git"
alias gco="git checkout"
alias gc="git commit"
alias gr="git reset"
alias gl="git pull"
alias gm="git merge"
alias gp="git push"
alias gb="git branch"
alias grb="git rebase"
alias gcp="git cherry-pick"

# dotfiles
alias dotfiles_commit="cd $HOME/dotfiles && git commit -am 'UPT: Updated dotfiles'; cd -"
alias dotfiles_push="cd $HOME/dotfiles && git push origin master; cd -"
