Here's the corrected and reorganized documentation in a Markdown (`.md`) file format:

```markdown
# Service Deployment Guide for TUR Cluster

This document outlines the steps to deploy a new service on the TUR Kubernetes cluster.

## Prerequisites
- Access to the TUR cluster
- Nginx ingress controller installed
- Basic knowledge of Kubernetes and Nginx

## 1. Create Ingress Manifest

Create a new YAML file for your service's ingress rules:

```bash
vi /home/ubuntu/proxmox-ubuntu-k8s/manifests/ingress-rules/<SVC_NAME>.yaml
```

Add the following content:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: <SVC_NAME>
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  ingressClassName: nginx
  rules:
  - host: <SVC_INGRESS_HOST>
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: <SVC_NAME>
            port:
              number: 80
```

## 2. Apply Ingress Configuration

Deploy the ingress rules to your cluster:

```bash
kubectl apply -f /home/ubuntu/proxmox-ubuntu-k8s/manifests/ingress-rules/<SVC_NAME>.yaml
```

## 3. Configure Nginx Proxy

Create a new Nginx configuration file:

```bash
vi /etc/nginx/sites-available/<SVC_NAME>-ingress-proxy
```

Add the following configuration:

```nginx
server {
    listen <SVC_PORT>;
    server_name _;

    location / {
        proxy_pass http://10.0.1.240;
        proxy_set_header Host <SVC_INGRESS_HOST>;
    }
}
```

## 4. Enable Nginx Configuration

1. Create a symbolic link to enable the site:
   ```bash
   sudo ln -s /etc/nginx/sites-available/<SVC_NAME>-ingress-proxy /etc/nginx/sites-enabled/
   ```

2. Test and reload Nginx:
   ```bash
   sudo nginx -t && sudo nginx -s reload
   ```

## Placeholder Reference

| Placeholder          | Description                                  | Example Value          |
|----------------------|----------------------------------------------|------------------------|
| `<SVC_NAME>`         | Name of your Kubernetes service             | `my-web-app`           |
| `<SVC_INGRESS_HOST>` | Hostname for ingress access                 | `app.example.com`      |
| `<SVC_PORT>`         | Port number for the Nginx proxy             | `8080`                 |

## Verification Steps

1. Check ingress status:
   ```bash
   kubectl get ingress <SVC_NAME>
   ```

2. Verify Nginx is listening on the correct port:
   ```bash
   sudo netstat -tulnp | grep nginx
   ```

3. Test access to your service:
   ```bash
   curl -H "Host: <SVC_INGRESS_HOST>" http://localhost:<SVC_PORT>
   ```

## Troubleshooting

- If Nginx fails to reload, check syntax with:
  ```bash
  sudo nginx -t
  ```

- For ingress issues, check logs:
  ```bash
  kubectl logs -n ingress-nginx <ingress-controller-pod>
  ```

- Verify service endpoints:
  ```bash
  kubectl get endpoints <SVC_NAME>
  ```
```

You can save this content to a file with `.md` extension, for example `tur-cluster-service-deployment.md`. The Markdown format provides better readability and can be easily rendered by documentation systems or GitHub.
