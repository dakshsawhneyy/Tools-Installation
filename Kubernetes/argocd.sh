kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for it to be ready (this can take a couple of minutes):
kubectl wait --for=condition=ready pod --all -n argocd --timeout=5m

kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get the initial password by running this in your original terminal:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
