# Install HELM

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
&& chmod 700 get_helm.sh \
&& ./get_helm.sh

# Get KUBECONFIG

sudo mkdir -p $HOME/.kube \
&& sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config \
&& sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Configure SSH

ssh-keygen -t rsa -b 4096 -C "ubuntu@vm-k8s-dev-01-cp-01"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
