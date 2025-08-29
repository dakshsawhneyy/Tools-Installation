helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
kubectl create namespace monitoring
helm install kind-prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --set prometheus.service.nodePort=30000 --set prometheus.service.type=NodePort --set grafana.service.nodePort=31000 --set grafana.service.type=NodePort --set alertmanager.service.nodePort=32000 --set alertmanager.service.type=NodePort --set prometheus-node-exporter.service.nodePort=32001 --set prometheus-node-exporter.service.type=NodePort
kubectl get svc -n monitoring
kubectl get namespace

# Expose these services
kubectl port-forward svc/kind-prometheus-kube-prome-prometheus -n monitoring 9090:9090 --address=0.0.0.0 &
kubectl port-forward svc/kind-prometheus-grafana -n monitoring 31000:80 --address=0.0.0.0 &

# Prom Queries
sum (rate (container_cpu_usage_seconds_total{namespace="default"}[1m])) / sum (machine_cpu_cores) * 100
sum (container_memory_usage_bytes{namespace="default"}) by (pod)
sum(rate(container_network_receive_bytes_total{namespace="default"}[5m])) by (pod)
sum(rate(container_network_transmit_bytes_total{namespace="default"}[5m])) by (pod)

# In K8S, we don't need prom-clien.yml instead we need ServiceMonitor
# create ServiceMonitor.yml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: backend-servicemonitor
  namespace: monitoring
  labels:
    release: kind-prometheus   # match your Prometheus release name
spec:
  selector:
    matchLabels:
      app: backend   # must match your backend service's labels
  namespaceSelector:
    matchNames:
      - mtrack
  endpoints:
    - port: http-metrics
      path: /metrics
      interval: 15s

# Then
helm upgrade --install kind-prometheus prometheus-community/kube-prometheus-stack   -n monitoring --create-namespace
kubectl get servicemonitor -n monitoring
kubectl describe servicemonitor backend-servicemonitor -n monitoring


