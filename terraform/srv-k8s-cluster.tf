resource "proxmox_vm_qemu" "srv-k8s-master" {
  count = var.ci_k8s_master_count
  name = "k8s-master"
  desc = "Kubernetes Master Nodes"
  vmid = var.ci_start_vmid + count.index
  target_node = "pve"

  clone = "ubuntu-cloud-init"

  agent = 1
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096

  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"
  cloudinit_cdrom_storage = "local-lvm"
  onboot = true

  os_type = "cloud-init"
  ipconfig0 = "ip=${var.ci_k8s_base_master_ip}${count.index}/${var.ci_network_cidr},gw=${var.ci_ip_gateway}"
  nameserver = "8.8.8.8 8.8.4.4"
  searchdomain = "piinalpin.lab"
  ciuser = var.ci_user
  cipassword = var.ci_password
  sshkeys = <<EOF
  ${file(var.ci_ssh_public_key)}
  EOF

  network {
    bridge = "vmbr0"
    model = "virtio"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size = 20
          storage = "local-lvm"
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }
}

resource "proxmox_vm_qemu" "srv-k8s-nodes" {
  count = var.ci_k8s_node_count
  name = "k8s-node-${count.index + 1}"
  desc = "Kubernetes Node ${count.index + 1}"
  vmid = var.ci_start_vmid + (count.index + var.ci_k8s_master_count)
  target_node = "pve"

  clone = "ubuntu-cloud-init"

  agent = 1
  cores = 1
  sockets = 1
  cpu = "host"
  memory = 2048

  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"
  cloudinit_cdrom_storage = "local-lvm"
  onboot = true

  os_type = "cloud-init"
  ipconfig0 = "ip=${var.ci_k8s_base_node_ip}${count.index}/${var.ci_network_cidr},gw=${var.ci_ip_gateway}"
  nameserver = "8.8.8.8 8.8.4.4"
  searchdomain = "piinalpin.lab"
  ciuser = var.ci_user
  cipassword = var.ci_password
  sshkeys = <<EOF
  ${file(var.ci_ssh_public_key)}
  EOF

  network {
    bridge = "vmbr0"
    model = "virtio"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size = 20
          storage = "local-lvm"
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }
}