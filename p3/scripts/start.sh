#!/bin/bash
#newgrp docker

##Let’s setup our cluster with 2 worker nodes (–agents in k3d command line) and expose the HTTP load balancer on the host on port 8080 (so that we can interact with our application)
echo -e "\e[32m\nCreating cluster:\e[0m"
k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2

echo -e "\e[32m\nCreating namespaces:\e[0m"
kubectl create namespace argocd
kubectl create namespace dev


##  apply this script from the ArgoCD team, which will take care of the rest.
echo -e "\e[32m\nApplying stable manifests for ArgoCD:\e[0m"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
## Use the watch command to ensure the pods are running and ready.
kubectl wait --for=condition=Ready pods --all -n argocd




## We want our work inside ArgoCD to be hosted in a dedicated project named iot-project. 
## Allow only in-cluster deployments in the dev namespace and only for the acaren github repositories.
echo -e "\e[32m\nApplying config 'project.yaml':\e[0m"
kubectl apply -f ../confs/project.yaml -n argocd

## Next, we will create an ArgoCD Application which will synchronize our Kubernetes manifests
## hosted in the app folder on our github repository feature branch featurebranch_1 with the associated resources inside the dev namespace on our local cluster:
echo -e "\e[32m\nApplying config 'application.yaml':\e[0m"
kubectl apply -f ../confs/application.yaml -n argocd


## to get access to ArgoCD’s web interface, we need to expose the argocd-server service on local machine:
echo -e "\e[32m\nExposing the argocd-server service on our local machine:\e[0m"
kubectl port-forward svc/argocd-server -n argocd 8888:443
