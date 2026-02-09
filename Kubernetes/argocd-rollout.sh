# Create the namespace
kubectl create namespace argo-rollouts

# Install the latest stable version
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64
chmod +x ./kubectl-argo-rollouts-linux-amd64
sudo mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

---

# Rollout
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: sample-rollout
  namespace: default
spec:
  replicas: 4
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
        role: web
    spec:
      containers:
        - name: sample-app
          image: dakshsawhneyy/helloworld-v1:latest
          ports:
            - containerPort: 8000
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"
  strategy:
    canary: #Indicates that the rollout should use the Canary strategy
      # maxSurge: '25%'
      # maxUnavailable: 0
      steps:
        - setWeight: 25
        - pause:
            duration: 10m # wait for 10 mins
        - setWeight: 50
        - pause: {} # pause indefinitely
