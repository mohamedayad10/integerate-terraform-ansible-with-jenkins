#!/bin/bash

# this script is for installing gogs server on vm2

#Install Required packages
sudo yum -y update
sudo yum -y upgrade
sudo yum -y install git
#Install a mysql database
sudo dnf update -y
sudo dnf install -y  mariadb105-server
sudo systemctl restart mariadb.service
### configure maraidb ###
#sudo mysql_secure_installation
#Set root password? [Y/n] Y
#Remove anonymous users? [Y/n] Y
#Disallow root login remotely? [Y/n] Y
#Remove test database and access to it? [Y/n] Y
#Reload privilege tables now? [Y/n] Y
#All done!  If you've completed all of the above steps, your MariaDB
#installation should now be secure.

# Create a mysql database and user for Gogs, and grant permissions to the user using the following commands

sudo mysql -uroot  -e "CREATE DATABASE gogs DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
sudo mysql -uroot  -e "CREATE USER 'gogsuser'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -uroot  -e "GRANT ALL PRIVILEGES ON gogs.* TO 'gogsuser'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;"
sudo mysql -uroot  -e "FLUSH PRIVILEGES;"

### Install GOGS ###
sudo groupadd git
sudo mkdir /opt/gogs
sudo useradd -s /bin/nologin -g git -d /opt/gogs -M git
wget https://dl.gogs.io/0.11.53/gogs_0.11.53_linux_amd64.tar.gz
sudo tar -zxvf gogs_0.11.53_linux_amd64.tar.gz -C /opt
sudo chown -R git:git /opt/gogs
sudo cp /opt/gogs/scripts/systemd/gogs.service /lib/systemd/system/
sudo sed -i 's#/home/git#/opt#g' /lib/systemd/system/gogs.service
sudo sed -i 's#HOME=/opt#HOME=/opt/gogs#g' /lib/systemd/system/gogs.service
sudo systemctl daemon-reload
sudo systemctl restart gogs.service
sudo systemctl enable gogs.service