# Installation

helm repo add longhorn https://charts.longhorn.io
helm repo update
helm install longhorn longhorn/longhorn \
  --namespace longhorn-system \
  --create-namespace \
  --version 1.6.2 \
  --set defaultSettings.defaultDataPath="/var/mnt/longhorn"

