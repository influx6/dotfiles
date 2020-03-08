#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt-get install build-essential curl file git

sudo apt -y purge python-pip
sudo python -m pip uninstall pip
sudo apt -y install python-pip
pip install --upgrade pip
echo "export PATH=\"${HOME}/.local/bin:$PATH\"" >>"${HOME}"/.bashrc

sudo apt remove gnupg gpg
sudo apt install -y gnupg2 fish tree graphviz build-essential unzip socat curl apt-transport-https ca-certificates 
sudo apt install -y axel aria2 byobu

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt install -y kubectl google-cloud-sd byobu

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
brew install hello

export GO_VERSION=1.11.4
curl -O "https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz"
sudo mv /usr/local/go /usr/local/go.bak.$GO_VERSION # if installing new version
sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y yarn


# Export key to `key.asc` file and then import
gpg --import key.asc
# or add --pinentry-mode if there is ap problem with entering the password
gpg --import --pinentry-mode loopback key.asc

git config --global core.filemode false
git config --global core.autocrlf input
git config --global commit.gpgsign true  
git config --global user.signingkey E25C1E01F3A98447  
git config --global gpg.program /usr/bin/gpg  
git config --global user.email trinoxf@gmail.com
git config --global user.name Alex Ewetumo

git config --global url."git@gitlab.1password.io:".insteadOf "https://gitlab.1password.io/"  
git config --global url."git@gitlab.com:".insteadOf "[https://gitlab.com](https://gitlab.com)"


echo “Test” | gpg --clear-sign


gcloud init
gcloud container clusters get-credentials cluster-dev
