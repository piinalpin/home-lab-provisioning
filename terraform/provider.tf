terraform {
  required_version = ">= 1.7.4"

  required_providers {
    proxmox = {
        source = "telmate/proxmox"
        version = "3.0.1-rc1"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type = string
  sensitive = true
}

variable "ci_ssh_public_key" {
  type = string
  sensitive = true
}

variable "ci_ssh_private_key" {
  type = string
  sensitive = true
}

variable "ci_user" {
  type = string
  sensitive = true
}

variable "ci_password" {
  type = string
  sensitive = true
}

variable "ci_k8s_master_count" {
  type = number
}

variable "ci_k8s_node_count" {
  type = number
}

variable "ci_k8s_base_master_ip" {
  type = string
}

variable "ci_k8s_base_node_ip" {
  type = string
}

variable "ci_ip_gateway" {
  type = string
}

variable "ci_network_cidr" {
  type = number
}

variable "ci_start_vmid" {
  type = number
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  pm_tls_insecure = true

  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }

}