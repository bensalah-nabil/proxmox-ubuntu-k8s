## PVE HOST ##
# Configure SSH

sudo rm ~/.ssh/id_rsa
sudo rm ~/.ssh/id_rsa.pub
sudo rm ~/.ssh/config

sudo vi ~/.ssh/id_rsa
sudo vi ~/.ssh/id_rsa.pub

sudo vi ~/.ssh/id_rsa_git
sudo vi ~/.ssh/id_rsa_git.pub

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_git

sudo vi ~/.ssh/config
---
Host k8s-bastion
    HostName 137.74.93.251
    User ubuntu
    Port 22
    IdentityFile ~/.ssh/id_rsa
Host 10.0.1.*
    User ubuntu
    Port 22
    IdentityFile ~/.ssh/id_rsa
    ProxyJump k8s-bastion
---

chmod -R 400 ~/.ssh

# Edit the NIC

cp /etc/network/interfaces /etc/network/interfaces.original
vi /etc/network/interfaces
---
# Dedicated internal network for Kubernetes cluster
auto vmbr1
iface vmbr1 inet static
    address  10.0.1.1/24
    bridge-ports none
    bridge-stp off
    bridge-fd 0

    post-up   echo 1 > /proc/sys/net/ipv4/ip_forward
    post-up   iptables -t nat -A POSTROUTING -s '10.0.1.0/24' -o vmbr0 -j MASQUERADE
    post-down iptables -t nat -D POSTROUTING -s '10.0.1.0/24' -o vmbr0 -j MASQUERADE
---
ifreload -a

# Install Git

sudo apt install git
git config --global user.email root@pve-nabil
git clone git@github.com:bensalah-nabil/proxmox-ubuntu-k8s.git
cd proxmox-ubuntu-k8s

# Install Terraform

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform


# Setup Bastion 
bash -c "$(wget -qLO - https://raw.githubusercontent.com/khanh-ph/proxmox-scripts/master/create-vm-template/script.sh)"

qm clone 9000 9001 --name bastion --full true
qm set 9001 --sshkey ~/.ssh/id_rsa.pub
qm set 9001 --net0 virtio,bridge=vmbr0 --ipconfig0 ip=137.74.93.251/24,gw=137.74.93.254
qm set 9001 --net1 virtio,bridge=vmbr1 --ipconfig1 ip=10.0.1.2/24,gw=10.0.1.1
qm set 9001 --onboot 1
qm start 9001

# Create an IAC Token And Grant Permissions

# Create terraform Vars
vi terraform.tfvars

# Apply terraform

terraform init
terraform apply

# Install python

sudo apt update
sudo apt install python3 python3-pip pipx python3.11-venv

# Install Ansible

VENVDIR=kubespray-venv
KUBESPRAYDIR=kubespray
python3 -m venv $VENVDIR
source $VENVDIR/bin/activate
cd $KUBESPRAYDIR
pip install -U -r requirements.txt

# ansible apply

ansible -i inventory/tur/inventory.ini -m ping all
ansible-playbook -i inventory/tur/inventory.ini cluster.yml --become
deactivate
