Here's a complete example demonstrating how to set up an NGINX Ingress Controller on a local Kubernetes cluster (like Minikube or Kind), including MetalLB for LoadBalancer support and sample applications:

---

# **Complete NGINX Ingress Controller Setup on Local Kubernetes**

## **Prerequisites**
- Kubernetes cluster (Minikube, Kind, or kubeadm-based)
- `kubectl` installed
- Helm v3+ installed

---

## **1. Install NGINX Ingress Controller via Helm**

```bash
# Add the Helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install NGINX Ingress Controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --set controller.service.type=LoadBalancer
```

Verify installation:
```bash
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx  # Note the EXTERNAL-IP (pending until MetalLB is installed)
```

---

