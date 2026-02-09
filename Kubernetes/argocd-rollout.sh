# Create the namespace
kubectl create namespace argo-rollouts

# Install the latest stable version
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
