#!/bin/bash

echo -e "\e[32m\nUpgrading apps:\e[0m"
sudo apt update -y
sudo apt upgrade -y

sudo apt install curl -y

echo -e "\e[32m\nInstalling Docker & Kubectl dependencies:\e[0m"
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

## Install Docker
echo -e "\e[32m\nInstalling Docker:\e[0m"
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
## to use Docker without sudo:
sudo groupadd docker
sudo gpasswd -a $USER docker

## Install Kubectl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Install k3d dependencies
echo -e "\e[32m\nInstalling k3d dependencies:\e[0m"
sudo apt-get install -y bridge-utils

## Install K3d
echo -e "\e[32m\nInstalling k3d:\e[0m"
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

echo -e "\e[33m\nINSTALLATION SUCCESSFULLY COMPLETED\e[0m\n"
newgrp docker
