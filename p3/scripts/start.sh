newgrp docker

##Let’s setup our cluster with 2 worker nodes (–agents in k3d command line) and expose the HTTP load balancer on the host on port 8080 (so that we can interact with our application)
k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2

kubectl create namespace argocd
kubectl create namespace dev


##  apply this script from the ArgoCD team, which will take care of the rest.
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
## Use the watch command to ensure the pods are running and ready.
kubectl wait --for=condition=Ready pods --all -n argocd