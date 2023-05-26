#!/bin/bash
#newgrp docker

##Let’s setup our cluster with 2 worker nodes (–agents in k3d command line) and expose the HTTP load balancer on the host on port 8080 (so that we can interact with our application)
##--api-port - by default, no API-Port is exposed. It’s used to have k3s‘s API-Server listening on port 6443
echo -e "\e[32m\nCreating cluster:\e[0m"
k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2 --wait

echo -e "\e[32m\nCreating namespaces:\e[0m"
kubectl create namespace argocd
kubectl create namespace dev


##  apply this script from the ArgoCD team, which will take care of the rest.
echo -e "\e[32m\nApplying stable manifests for ArgoCD:\e[0m"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
## Use the watch command to ensure the pods are running and ready.
echo -e "\e[32m\nAwaiting pods are running and ready...\e[0m"
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=120s

echo -e "\e[32m\nApplying new password to ArgoCD:\e[0m"
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$12$Iy3op7PDM/PWJ/8kRyn0ROWImQa5TSzQmL.8GTj0dNpEagZbQsnPG",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

## We want our work inside ArgoCD to be hosted in a dedicated project named iot-project. 
## Allow only in-cluster deployments in the dev namespace and only for the acaren github repositories.
echo -e "\e[32m\nApplying config 'project.yaml':\e[0m"
kubectl apply -f ../confs/project.yaml -n argocd

## Next, we will create an ArgoCD Application which will synchronize our Kubernetes manifests
## hosted in the app folder on our github repository (https://github.com/jesuisstan/acaren_iot_p3.git)
## with the associated resources inside the dev namespace on our local cluster:
echo -e "\e[32m\nApplying config 'application.yaml':\e[0m"
kubectl apply -f ../confs/application.yaml -n argocd

echo -e "\e[32m\nAwaiting pods are running and ready...\e[0m"
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=42s


echo -e "\e[33m\nARGO CD IS  DEPLOYED!\nRUN THE THE FOLLOWING CMD TO WORK WITH IT:\n
1) to access the dashboard:\n
kubectl port-forward svc/argocd-server -n argocd 9999:443
\n
2) to access wil's app:\n
kubectl port-forward svc/wil-playground -n dev 8888:8888
\e[0m"

### to get access to ArgoCD’s web interface, we need to expose the argocd-server service on local machine:
#echo -e "\e[32m\nExposing the argocd-server service on our local machine:\e[0m"
#kubectl port-forward svc/argocd-server -n argocd 8888:443
