#au début
sudo apt update
sudo apt full-upgrade -y

#commande indispensable
sudo apt install htop -y

#php
sudo apt install php -y
#mariadb + configuratuin
sudo apt install mariadb-server -y
sudo apt install php-mysql -y
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
git config --global user.name "felixleo22"
git config --global user.email leofelixoff@outlook.fr
git config --global credential.helper 'cache --timeout 36000'

#zsh
sudo apt install zsh -y
#oh my zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
## changer le ZSH_THEME dans .zshrc
#ZSH_THEME="agnoster"
sudo apt-get install fonts-powerline

#nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

#python
sudo apt install python3-dev python3-pip python3-setuptools -y
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


#docker
sudo apt install docker.io
sudo apt install docker-compose


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
