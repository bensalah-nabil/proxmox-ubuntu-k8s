#!/bin/bash

set -euo pipefail

# Function to handle errors
error_handler() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo -e "\e[31mThe script exited with status ${exit_code}.\e[0m" 1>&2
        cleanup
        exit ${exit_code}
    fi
}

trap error_handler EXIT

# Function to run commands and capture stderr
run_cmd() {
    local cmd="$1"
    local stderr_file=$(mktemp)

    if ! eval "$cmd" > /dev/null 2>$stderr_file; then
        echo -e "\e[31mError\n Command '$cmd' failed with output:\e[0m" 1>&2
        cat $stderr_file | awk '{print " \033[31m" $0 "\033[0m"}' 1>&2
        rm -f $stderr_file
        exit 1
    fi

    rm -f $stderr_file
}

# Function to print OK message
print_ok () {
    echo -e "\e[32mOK\e[0m"
}

# Default values for Kali Linux
df_kali_ver="2024.4"
df_vm_tmpl_id="9009"
df_vm_tmpl_name="kali-linux-template"

# Prompt for user input
read -p "Enter Kali Linux version (default: ${df_kali_ver}): " kali_ver
kali_ver="${kali_ver:-$df_kali_ver}"

read -p "Enter Proxmox Template ID (default: ${df_vm_tmpl_id}): " vm_tmpl_id
vm_tmpl_id="${vm_tmpl_id:-$df_vm_tmpl_id}"

read -p "Enter Proxmox Template Name (default: ${df_vm_tmpl_name}): " vm_tmpl_name
vm_tmpl_name="${vm_tmpl_name:-$df_vm_tmpl_name}"

# Get list of storages
storages=($(pvesm status | awk 'NR>1 {print $1}'))
echo " Available storages:"
for i in "${!storages[@]}"; do
    echo "  $i: ${storages[$i]}"
done

# Prompt for user input for storage
read -p "Enter the index number of the storage to put the VM template into (default: 0): " storage_index
storage_index="${storage_index:-0}"
vm_disk_storage="${storages[$storage_index]}"

# Kali Linux image URL
kali_img_url="https://repo.ialab.dsu.edu/kali-images/kali-${kali_ver}/kali-linux-${kali_ver}-installer-amd64.iso"
kali_img_filename=$(basename $kali_img_url)
df_iso_path="/var/lib/vz/template/iso"
script_tmp_path=/tmp/proxmox-scripts

install_lib () {
    local name="$1"
    echo -n "Installing $name..."
    run_cmd "apt-get install -y $name"
    print_ok
}

init () {
    cleanup
    install_lib "libguestfs-tools"
    mkdir -p $script_tmp_path
    cd $script_tmp_path
}

get_image () {
    local existing_img="$df_iso_path/$kali_img_filename"
    
    if [ -f "$existing_img" ]; then
        echo -n "The image file exists in Proxmox ISO storage. Copying..."
        run_cmd "cp $existing_img $kali_img_filename"
        print_ok
    else
        echo -n "The image file does not exist in Proxmox ISO storage. Downloading..."
        run_cmd "wget $kali_img_url -O $kali_img_filename"
        print_ok

        echo -n "Copying the image to Proxmox ISO storage..."
        run_cmd "cp $kali_img_filename $existing_img"
        print_ok
    fi
}

create_vm_tmpl () {
    echo -n "Creating VM template..."
    run_cmd "qm destroy $vm_tmpl_id --purge || true"
    run_cmd "qm create $vm_tmpl_id --name $vm_tmpl_name --memory 4096 --cores 2 --net0 virtio,bridge=vmbr0"
    run_cmd "qm set $vm_tmpl_id --scsihw virtio-scsi-single"
    run_cmd "qm set $vm_tmpl_id --scsi0 $vm_disk_storage:32,format=qcow2"
    run_cmd "qm set $vm_tmpl_id --cdrom $vm_disk_storage:iso/$kali_img_filename"
    
    # Correct boot order syntax for newer Proxmox versions
    run_cmd "qm set $vm_tmpl_id --boot order=scsi0"
    run_cmd "qm set $vm_tmpl_id --bootdisk scsi0"
    
    run_cmd "qm set $vm_tmpl_id --ide2 $vm_disk_storage:cloudinit"
    run_cmd "qm set $vm_tmpl_id --serial0 socket --vga serial0"
    run_cmd "qm set $vm_tmpl_id --agent enabled=1"
    
    echo -e "\n\e[32mVM template created with ID ${vm_tmpl_id}\e[0m"
    echo -e "\n\e[33mNext steps:\e[0m"
    echo "1. Start the VM (ID $vm_tmpl_id) in Proxmox web interface"
    echo "2. Complete the Kali Linux installation (select the 32GB disk)"
    echo "3. Install QEMU guest agent inside the VM:"
    echo "   sudo apt update && sudo apt install -y qemu-guest-agent"
    echo "4. Perform any additional configuration"
    echo "5. Shutdown the VM when complete"
    echo "6. Convert to template:"
    echo "   qm template $vm_tmpl_id"
    print_ok
}

cleanup () { 
    echo -n "Performing cleanup..."
    rm -rf $script_tmp_path 
    print_ok
}

# Main script execution
init
get_image
create_vm_tmpl
