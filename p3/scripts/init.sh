#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

sudo apt install curl -y


## Install Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
## to use Docker without sudo:
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker


## Install Kubectl
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Install k3d dependencies
sudo apt-get install -y bridge-utils

## Install K3d
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

echo "Installation completed"
docker version
kubectl version --client
k3d version
