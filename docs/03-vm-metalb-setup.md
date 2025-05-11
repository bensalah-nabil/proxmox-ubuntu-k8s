## **2. Install MetalLB for Local LoadBalancer Support**

MetalLB assigns external IPs to services of type `LoadBalancer` in bare-metal/local clusters.

### **Enable strictARP (required for MetalLB)**
```bash
kubectl edit configmap -n kube-system kube-proxy
```
Add/modify:
```yaml
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true
```

### **Install MetalLB**
```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.10/config/manifests/metallb-native.yaml -n metallb-system
```

Wait for pods to be ready:
```bash
kubectl get pods -n metallb-system
```

### **Configure IP Address Pool**
Replace `192.168.1.100-192.168.1.110` with your local network range.

```bash
ubectl apply -f /proxmox-ubuntu-k8s/manifests/meta-lb/mlb.yaml
```

Verify NGINX Ingress now has an external IP:
```bash
kubectl get svc -n ingress-nginx
```
Example output:
```
NAME                       TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)                      AGE
ingress-nginx-controller   LoadBalancer   10.96.100.10   192.168.1.100  80:32456/TCP,443:32543/TCP   5m
```

---

