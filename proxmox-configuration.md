# Setup Proxmox
**Note:** Use ethernet LAN first for update and upgrade

### Configure Proxmox No Subscription
- Add `pve-no-subscription` reposiutory
    ```bash
    deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
    ```
- Comment out this line on `/etc/apt/sources.list.d/ceph.list`
    ```bash
    deb https://enterprice.proxmox.com/debian/ceph-quincy bookworm enterprice
    ```
- Comment out this line on `/etc/apt/sources.list.d/pve-enterprice.list`
    ```bash
    deb https://enterprice.proxmox.com/debian/pve bookworm enterprice
    ```
- Update and upgrade
    ```bash
    apt update
    apt upgrade
    ```
- Install `wireless-tools`
    ```bash
    apt install -y wireless-tools
    ```
- Backup network interface
    ```bash
    cp /etc/network/interfaces /etc/network/interfaces.bak
    ```
- Configure network interface at `/etc/network/interfaces`
    ```conf
    auto lo
    iface lo inet loopback

    iface enp0s31f6 inet manual

    auto vmbr0
    iface vmbr0 inet manual

    auto wlp3s0
    iface wlp3s0 inet static
        address 192.168.1.4/24
        netmask 255.255.255.0
        gateway 192.168.1.1
        wpa-ssid "Your SSID"
        wpa-psk "your-password"

    source /etc/network/interfaces.d/*
    ```

    **Note:** 
    - enp0s31f6 is ethernet interface, adjust with actual interface
    - wlp3s0 is wlan interface, adjust with actual interface
- Configure name server at `/etc/resolv.conf`
    ```conf
    search localhost
    nameserver 192.168.1.1
    nameserver 8.8.8.8
    nameserver 8.8.4.4
    ```
- Restart networking
    ```bash
    systemctl restart networking
    ```
- Try ping `google.com` or `piinalpin.com` if can get reply should be done.