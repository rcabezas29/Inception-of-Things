# Create a cluster named "cluster" with 1 node
sudo k3d cluster create cluster

# Create two namespaces
sudo kubectl create -f manifests/namespace.yaml

# Create argocd deployment
sudo curl https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/install.yaml | kubectl apply -n argocd -f -