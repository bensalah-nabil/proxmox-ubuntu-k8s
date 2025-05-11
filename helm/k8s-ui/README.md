# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard -f values.yaml
# Troubleshooting
kubectl -n kubernetes-dashboard logs -l app.kubernetes.io/instance=kubernetes-dashboard -f --max-log-requests=6

