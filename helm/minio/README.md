helm repo add minio https://charts.min.io/
helm repo update
helm install minio minio/minio
  --namespace minio-system \
  --create-namespace \
  -f helm/minio/values.yaml
