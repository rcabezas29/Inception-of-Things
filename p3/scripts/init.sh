# Create a cluster named "cluster" with 1 node
sudo k3d cluster create cluster -p "80:80@loadbalancer" -p "443:443@loadbalancer"

# Create two namespaces
sudo kubectl create namespace argocd
sudo kubectl create namespace dev

# Create argocd deployment
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for pods to be ready
sudo kubectl wait --for=condition=Ready pods --all -n argocd

# Set hash of password (https://en.wikipedia.org/wiki/Bcrypt) of argocd dashboard (password)
sudo kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

# Deploy argocd application listener
sudo kubectl apply -f /vagrant/manifests/application.yaml

# Port forward argocd dashboard to port 8081
sudo kubectl port-forward svc/argocd-server --address="192.168.56.97" -n argocd 8081:80 &