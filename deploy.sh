#!/bin/bash

# update and upgrade
clear
echo "Updating and Upgrading..."
sudo apt update -y && sudo apt upgrade -y

# install apache2
clear
echo "Installing apache2..."
sudo apt install apache2 -y

# create the website folder
clear
echo "Creating the website folder..."
sudo mkdir /var/www/landing
cd /var/www/landing

# move the cloned folder
clear
echo "Moving the cloned website files..."
sudo mv landing/* /var/www/landing/
sudo rm -rf ../01-AdministrasiServer-ApacheDeployment

# copy the default virtualhost page conf
clear
echo "Configuring virtualhost..."
cd /etc/apache2/sites-available
sudo cp 000-default.conf landing.conf

# rename default webmaster address to myself and change default page to the new one
clear
sudo sed -i 's;webmaster@localhost;adjipangestu00@student.ub.ac.id;' landing.conf
sudo sed -i 's;/var/www/html;/var/www/landing/;' landing.conf

# enable the virtualhost and reload the service
clear
echo "Restarting apache2 service..."
sudo a2ensite landing.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2

clear
echo "Website deployment is finished!"
