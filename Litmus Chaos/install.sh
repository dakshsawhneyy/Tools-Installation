helm repo add litmuschaos https://litmuschaos.github.io/litmus-helm/
helm repo update

# This will create a litmus namespace and install all the necessary components for running chaos experiments.
kubectl create ns litmus

# Install Litmus ChaosCenter using Helm.
helm install chaos litmuschaos/litmus --namespace=litmus --set portal.frontend.service.type=NodePort

kubectl get pods -n litmus

kubectl port-forward svc/chaos-litmus-frontend-service 9091:9091 -n litmus
