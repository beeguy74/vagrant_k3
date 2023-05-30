#!/bin/bash

# Update package list
sudo apt update

# Install msc
sudo apt install net-tools -y
sudo apt install vim -y
sudo apt install git -y

ssh-keygen -t ed25519 -C "beeguy74@gmail.com" -f ~/.ssh/id_ed25519 -N ""


# Install VirtualBox
sudo apt install virtualbox -y

# Download Vagrant package
wget https://releases.hashicorp.com/vagrant/2.2.18/vagrant_2.2.18_x86_64.deb

# Install Vagrant
sudo dpkg -i vagrant_2.2.18_x86_64.deb

# Cleanup downloaded package
rm vagrant_2.2.18_x86_64.deb

# Verify installations
vagrant --version
vboxmanage --version
