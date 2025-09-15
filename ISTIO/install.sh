# Step 1 - Download the Istio CLI (istioctl)
curl -L https://istio.io/downloadIstio | sh -

cd istio-1.23.0

# Add istioctl to your path so you can run it from anywhere:
export PATH=$PWD/bin:$PATH

istioctl version

# Step 2 - Install Istio on Your Kind Cluster
istioctl install --set profile=demo -y

# Step 3: Enable Automatic Sidecar Injection
kubectl label namespace app istio-injection=enabled

# Step 4: Relaunch Your Application to Trigger the Injection
kubectl rollout restart deployment -n app
kubectl get pods -n app
