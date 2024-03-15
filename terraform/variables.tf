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