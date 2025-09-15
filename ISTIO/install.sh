curl -L https://istio.io/downloadIstio | sh -

cd istio-1.23.0

# Add istioctl to your path so you can run it from anywhere:
export PATH=$PWD/bin:$PATH

istioctl version
