# Proxmox API
proxmox_api_url             = "https://pve.piinalpin.lab:8006/api2/json"
proxmox_api_token_id        = "terraform-prov@pve!terraform"
proxmox_api_token_secret    = "f6d89c4b-693c-47d6-b121-2932e747c75c"

# Cloud init configuration
ci_ssh_public_key       = "../.ssh/homelab.pub"
ci_ssh_private_key      = "../.ssh/homelab"
ci_user                 = "k8s"
ci_password             = "secret"
ci_k8s_master_count     = 1
ci_k8s_node_count       = 2
ci_k8s_base_master_ip   = "192.168.56.1" # Will generate 192.168.56.1X
ci_k8s_base_node_ip     = "192.168.56.2" # Will generate 192.168.56.2X
ci_ip_gateway           = "192.168.56.1"
ci_network_cidr         = 24
ci_start_vmid           = 100