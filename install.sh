#!/bin/bash

#declaration des variables

success=0
echec=0

# $1 le code de retour
# $2 le nom de la commande
function recap() {
    if [ $1 -ne 0 ] 
    then
        echec=`expr $echec + 1`
        tabechec[$echec]=$2
    else
 	    success=`expr $success + 1`
        tabsuccess[$success]=$2
    fi
}

############## upgrade ##############

sudo apt update
recap($('echo $?'), "update")

sudo apt full-upgrade -y
recap($('echo $?'), "full-upgrade")

############## git ##############

## faire en sorte de demander l'user.name et user.email
sudo apt install git -y
recap($('echo $?'), "git")

echo -e "Saisit ton user.name git"
read username
git config --global user.name $username
recap($('echo $?') "git user.name")

echo -e "Saisit ton user.email git"
read useremail
git config --global user.email $useremail
recap($('echo $?') "git user.email")

git config --global credential.helper 'cache --timeout 36000'

############## langage ##############

#php
sudo apt install php -y
recap($('echo $?'), "php")
sudo apt install composer -y
recap($('echo $?'), "composer")

#nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
./install.sh
recap($('echo $?'), "nvm")

#node v12
nvm install 12

#sass
npm install -g sass
recap($('echo $?'), "sass")

#python
sudo apt install python3-dev python3-pip python3-setuptools -y
recap($('echo $?'), "module python")

############## commande indispensable ##############
sudo apt install htop -y
recap($('echo $?'), "htop")

#fuck
sudo pip3 install thefuck
recap($('echo $?'), "fuck")

############## base de données ##############

#mariadb + configuration
sudo apt install mariadb-server -y
recap($('echo $?'), "mariadb-serve")

sudo apt install php-mysql -y
recap($('echo $?'), "php-mysql")

#lancement de mariadb
systemctl start mariadb.service

#initialisation user root mdp root
sudo mysql --user root
UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';
CREATE DATABASE example;
GRANT ALL PRIVILEGES ON *.* TO "root"@"localhost" IDENTIFIED BY "root";
FLUSH PRIVILEGES;
QUIT;

#phpmyadmin
sudo apt-get install phpmyadmin -y
recap($('echo $?'), "phpmyadmin")

############## configuration du terminal ##############

#zsh
sudo apt install zsh -y
recap($('echo $?'), "zsh")

#oh my zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#ZSH_THEME="agnoster"
sed -i '/^ZSH_THEME=/s/robbyrussell/agnoster/' ~/.zshrc
sudo apt-get install fonts-powerline
recap($('echo $?'), "fonts-powerline")

#utilisation de nvm dans zsh
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc

############## docker ##############

#docker
sudo apt install docker.io
recap($('echo $?'), "docker")
sudo apt install docker-compose
recap($('echo $?'), "docker-compose")

# ajout group user
sudo usermod -a -G docker $USER
newgrp docker
sudo systemctl restart docker

############## programmes / logiciels ##############

#chrome 
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
recap($('echo $?'), "chrome")

#vscode
sudo snap install code --classic
recap($('echo $?'), "vscode")

#telegramm
sudo apt install telegram-desktop
recap($('echo $?'), "telegram")

#minecraft 
wget https://launcher.mojang.com/download/Minecraft.deb
dpkg -i Minecraft.deb
recap($('echo $?'), "Minecraft")
rm Minecraft.deb

#discord 
sudo snap install discord
recap($('echo $?'), "discord")

#postman
sudo snap install postman
recap($('echo $?'), "postman")

#teamviewer
wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
dpkg -i teamviewer_amd64.deb
recap($('echo $?'), "Teamviewer")
rm teamviewer_amd64.deb

############## upgrade ##############

sudo apt update
recap($('echo $?'), "update")

sudo apt full-upgrade -y
recap($('echo $?'), "full-upgrade")

############## generation d'un log ##############

touch log.txt
echo -e "Fin des installations, un fichier de log est fournit pour voir les succes et les echecs"

echo -e "Les succes" >> ./log.txt
for mot in ${tabsuccess[*]}
do
echo -e $mot >> ./log.txt
done

echo -e "Les echecs" >> ./log.txt
for mot in ${tabechec[*]}
do
echo -e $mot >> ./log.txt
done
