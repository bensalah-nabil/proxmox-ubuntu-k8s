#!/bin/bash
# PVE Host Setup Script with Full Manual SSH Key Control
set -euo pipefail

## Critical Manual Input Functions ##
function manual_edit() {
    local file="$1"
    local description="$2"
    
    echo ""
    echo "------------------------------------------------------------------"
    echo "MANUAL INPUT REQUIRED: ${description}"
    echo "Please edit the file: ${file}"
    echo "Press Enter to open vi editor..."
    echo "------------------------------------------------------------------"
    read -r
    vi "$file"
}

function manual_key_input() {
    local key_file="$1"
    local pub_file="${key_file}.pub"
    local key_type="$2"
    
    echo ""
    echo "------------------------------------------------------------------"
    echo "MANUAL SSH KEY INPUT REQUIRED: ${key_type} key"
    echo "Private key file: ${key_file}"
    echo "Public key file:  ${pub_file}"
    echo "Press Enter to create/edit these files..."
    echo "------------------------------------------------------------------"
    read -r
    
    # Create directory if needed
    mkdir -p "$(dirname "$key_file")"
    
    # Edit private key
    if [ ! -f "$key_file" ]; then
        echo "Creating new private key file..."
        touch "$key_file"
        chmod 600 "$key_file"
    fi
    vi "$key_file"
    
    # Edit public key
    if [ ! -f "$pub_file" ]; then
        echo "Creating new public key file..."
        touch "$pub_file"
        chmod 644 "$pub_file"
    fi
    vi "$pub_file"
    
    # Verify key pair
    if ! ssh-keygen -l -f "$key_file" &>/dev/null; then
        echo "ERROR: Invalid SSH key format in ${key_file}"
        echo "Please fix the key manually and rerun the script"
        exit 1
    fi
}

## SSH Configuration ##
echo "Initializing SSH setup..."
SSH_DIR="$HOME/.ssh"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Manual SSH key setup
manual_key_input "$SSH_DIR/id_rsa" "Main SSH"
manual_key_input "$SSH_DIR/id_rsa_git" "Git SSH"

# Add Git key to ssh-agent
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/id_rsa_git"

# Configure SSH client
manual_edit "$SSH_DIR/config" "SSH client configuration (bastion and internal nodes)"

## Network Configuration ## 
[Previous network setup code remains exactly the same...]

## Software Installation ##
[Previous software installation code remains exactly the same...]

## Git Configuration ##
manual_edit "$HOME/.gitconfig" "Git global configuration"

## Bastion Host Setup ##
[Previous bastion setup code remains exactly the same...]

## Terraform Configuration ##
manual_edit "terraform.tfvars" "Terraform variables"

## Kubernetes Deployment ##
[Previous k8s setup code remains exactly the same...]
