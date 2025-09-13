# This will create a litmus namespace and install all the necessary components for running chaos experiments.
kubectl apply -f https://litmuschaos.github.io/litmus/litmus-operator-v2.16.0.yaml

kubectl get pods -n litmus
