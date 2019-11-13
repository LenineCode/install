#!/bin/bash

#declaration des variables

success = 0
echec = 0

# $1 le code de retour
# $2 le nom de la commande
function recap() {
    if [ $1 = "0" ] then
        success = `expr $success + 1`
        tabsuccess[$success] = $2
    else
        echec = `expr $echec + 1`
        tabechec[$echec] = $2
    fi
}

#au début
sudo apt update
recap(echo $?, "update")

sudo apt full-upgrade -y
recap(echo $?, "full-upgrade")

#commande indispensable
sudo apt install htop -y
recap(echo $?, "htop")

#php
sudo apt install php -y
recap(echo $?, "php")
sudo apt install composer -y
recap(echo $?, "composer")

#mariadb + configuration
sudo apt install mariadb-server -y
recap(echo $?, "mariadb-serve")

sudo apt install php-mysql -y
recap(echo $?, "php-mysql")

systemctl start mariadb.service
##savoir s'il y a des erreurs : systemctl status mariadb.service 
#initialisation user root mdp root
sudo mysql --user root
UPDATE mysql.user SET Password = PASSWORD('root') WHERE User = 'root';
FLUSH PRIVILEGES;
exit

#git
## faire en sorte de demander l'user.name et user.email
sudo apt install git -y
recap(echo $?, "git")
git config --global user.name "felixleo22"
git config --global user.email leofelixoff@outlook.fr
git config --global credential.helper 'cache --timeout 36000'

#zsh
sudo apt install zsh -y
recap(echo $?, "zsh")
#oh my zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
## changer le ZSH_THEME dans .zshrc
#ZSH_THEME="agnoster"
sudo apt-get install fonts-powerline
recap(echo $?, "fonts-powerline")

#nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

#python
sudo apt install python3-dev python3-pip python3-setuptools -y
recap(echo $?, "module python")
#fuck
sudo pip3 install thefuck

#nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
#utilisation de nvm dans zsh
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc

#node v12
nvm install 12

#phpmyadmin
sudo apt-get install phpmyadmin -y
recap(echo $?, "phpmyadmin")

#docker
sudo apt install docker.io
recap(echo $?, "docker")
sudo apt install docker-compose
recap(echo $?, "docker-compose")


#chrome 
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

#vscode
sudo snap install code --classic

#minecraft 
wget https://launcher.mojang.com/download/Minecraft.deb
## executer le .deb

#discord
sudo snap install discord
