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

# $1 PID du processus qui a été éxécuté
function waitFinish() {
    wait $1
}

############## upgrade ##############

sudo apt update &
waitFinish $!
recap "$(echo $?)" "-update"

sudo apt full-upgrade -y &
waitFinish $!
recap "$(echo $?)" "-full-upgrade"

############## git ##############

## faire en sorte de demander l'user.name et user.email
sudo apt install git -y &
waitFinish $!
recap "$(echo $?)" "-git"

echo -e "Saisit ton user.name git"
read username
git config --global user.name $username
recap "$(echo $?)" "-user.name"

echo -e "Saisit ton user.email git"
read useremail
git config --global user.email $useremail
recap "$(echo $?)" "-user.email"

git config --global credential.helper 'cache --timeout 36000'

############## langage ##############

#php
sudo apt install php -y &
waitFinish $!
recap "$(echo $?)" "-php"
sudo apt install composer -y &
waitFinish $!
recap "$(echo $?)" "-composer"

#nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash &
waitFinish $!
./install.sh
recap "$(echo $?)" "-nvm"

#refresh
/bin/bash

#node v12
nvm install 12 &
waitFinish $!

#sass
npm install -g sass &
waitFinish $!
recap "$(echo $?)" "-sass"

#python
sudo apt install python3-dev python3-pip python3-setuptools -y &
waitFinish $!
recap "$(echo $?)" "-python"

############## commande indispensable ##############
sudo apt install htop -y &
waitFinish $!
recap "$(echo $?)" "-htop"

#fuck
sudo pip3 install thefuck &
waitFinish $!
recap "$(echo $?)" "-fuck"

############## base de données ##############

#mariadb + configuration
sudo apt install mariadb-server -y &
waitFinish $!
recap "$(echo $?)" "-mariadb-serve"

sudo apt install php-mysql -y &
waitFinish $!
recap "$(echo $?)" "-php-mysql"

#lancement de mariadb
sudo systemctl start mariadb.service

#initialisation user root mdp root
echo "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';
CREATE DATABASE example;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
QUIT;" > sudo mysql --user root

#phpmyadmin
sudo apt-get install phpmyadmin -y &
waitFinish $!
recap "$(echo $?)" "-phpmyadmin"

############## configuration du terminal ##############

#zsh
sudo apt install zsh -y &
waitFinish $!
recap "$(echo $?)" "-zsh"

#oh my zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" &
waitFinish $!

#ZSH_THEME="agnoster"
sed -i '/^ZSH_THEME=/s/robbyrussell/agnoster/' ~/.zshrc
sudo apt-get install fonts-powerline -y &
waitFinish $!
recap "$(echo $?)" "-fonts-powerline"

#utilisation de nvm dans zsh
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc
#dans .oh-my-zsh/themes/agnsoster.zsh-theme


############## docker ##############

#docker
sudo apt install docker.io -y &
waitFinish $!
recap "$(echo $?)" "-docker"
sudo apt install docker-compose -y &
waitFinish $!
recap "$(echo $?)" "-docker-compose"

# ajout group user
sudo usermod -a -G docker $USER
sudo systemctl restart docker

############## programmes / logiciels ##############

#chrome 
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &
waitFinish $!
sudo apt-get update &
waitFinish $!
sudo apt-get install google-chrome-stable -y &
waitFinish $!
recap "$(echo $?)" "-chrome"

#vscode
sudo snap install code --classic &
waitFinish $!
recap "$(echo $?)" "-vscode"

#telegramm
sudo apt install telegram-desktop -y &
waitFinish $!
recap "$(echo $?)" "-telegram"

#minecraft 
sudo snap install minecraft &
waitFinish $!
recap "$(echo $?)" "-Minecraft"

#discord 
sudo snap install discord &
waitFinish $!
recap "$(echo $?)" "-discord"

#postman
sudo snap install postman &
waitFinish $!
recap "$(echo $?)" "-postman"

#teamviewer
wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" &
waitFinish $!
sudo dpkg -i teamviewer_amd64.deb &
waitFinish $!
recap "$(echo $?)" "-Teamviewer"
rm teamviewer_amd64.deb

############## upgrade ##############

sudo apt update &
waitFinish $!
recap "$(echo $?)" "-update"

sudo apt full-upgrade -y &
waitFinish $!
recap "$(echo $?)" "-full-upgrade"

############## generation d'un log ##############

touch install.log
echo -e "Fin des installations, un fichier de log est fournit pour voir les succes et les echecs"

echo -e "Les succes" >> ./install.log
for mot in ${tabsuccess[*]}
do
echo -e $mot >> ./install.log
done

echo -e ' ' >> ./install.log

echo -e "Les echecs" >> ./install.log
for mot in ${tabechec[*]}
do
echo -e $mot >> ./install.log
done
