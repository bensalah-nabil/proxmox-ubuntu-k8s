# Add the Helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install NGINX Ingress Controller
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  -f helm/ingress-nginx/values.yaml

# Troubelshooting
kubectl get service --namespace ingress-nginx ingress-nginx-controller --output wide --watch

