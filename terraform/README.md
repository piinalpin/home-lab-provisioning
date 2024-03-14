### Configuration Cloud Init Template

Download ubuntu cloud init
```bash
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
```

Enable qemu agent
```bash
apt install libguestfs-tools
virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent,net-tools --truncate /etc/machine-id
```

Setup VM Template
```bash
qm create 8000 --name ubuntu-cloud-init --core 2 --memory 2048 --net0 virtio,bridge=vmbr0
```

Import disk
```bash
qm disk import 8000 jammy-server-cloudimg-amd64.img local-lvm
```

Attach disk to VM
```bash
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0
```

Set boot order disk
```bash
qm set 8000 --boot c --bootdisk scsi0
```

Activate Qemu Agent
```bash
qm set 8000 --agent 1
```

Set serial socket and vga for console and hotplug
```bash
qm set 8000 --serial0 socket
qm set 8000 --vga serial0
qm set 8000 --hotplug network,usb,disk
```

Convert to template
```bash
qm template 8000
```