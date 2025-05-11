## **3. Deploy Sample Applications**

### **Example 1: Simple Web App (DNS-Based Ingress)**
Deploy a test app:
```bash
kubectl create deployment demo-app --image=nginx
kubectl expose deployment demo-app --port=80
```

Create an Ingress rule for `demo.local`:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-app
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: "demo.local"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: demo-app
            port:
              number: 80
EOF
```

### **Example 2: Path-Based Routing**
Deploy another app:
```bash
kubectl create deployment another-app --image=httpd
kubectl expose deployment another-app --port=80
```

Create a path-based Ingress:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: path-based
spec:
  ingressClassName: nginx
  rules:
  - host: "demo.local"
    http:
      paths:
      - path: /app2
        pathType: Prefix
        backend:
          service:
            name: another-app
            port:
              number: 80
EOF
```

---

## **4. Test the Setup**

### **Update `/etc/hosts` (or Windows `hosts` file)**
Add the following line (replace `192.168.1.100` with your Ingress external IP):
```
192.168.1.100 demo.local
```

### **Access Applications**
- Open `http://demo.local` → Shows NGINX (demo-app).
- Open `http://demo.local/app2` → Shows Apache (another-app).

---

## **5. Verify Ingress Rules**
```bash
kubectl get ingress
```
Output:
```
NAME         CLASS   HOSTS        ADDRESS        PORTS   AGE
demo-app     nginx   demo.local   192.168.1.100  80      2m
path-based   nginx   demo.local   192.168.1.100  80      1m
```

---

## **Troubleshooting**
- If MetalLB doesn’t assign an IP, check logs:
  ```bash
  kubectl logs -n metallb-system -l app=metallb
  ```
- If Ingress returns 404, check NGINX controller logs:
  ```bash
  kubectl logs -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx
  ```

---

## **Conclusion**
You now have:
- NGINX Ingress Controller running.
- MetalLB providing external IPs.
- Sample apps accessible via host/path-based routing.

This setup mirrors production environments and can be extended with TLS, monitoring, and more.

