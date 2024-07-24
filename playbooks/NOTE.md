### Kubernetes

- `sudo apt update && sudo apt upgrade`
- `sudo systemctl disable systemd-resolved`
- `sudo systemctl mask systemd-resolved`
- install containerd `sudo apt install -y containerd` all vm
- `sudo mkdir /etc/containerd`
- `containerd config default | sudo tee /etc/containerd/config.toml` -> can reuse `files/config.toml`
- Update `io.containerd.grpc.v1.cri".containerd.runtimes.runc.options` set `SystemdCgroup = true`
- create file `/etc/crictl.yaml` add this line
    ```yaml
    runtime-endpoint: unix:///var/run/containerd/containerd.sock
    ```
- Ensure disabled swap
- `/etc/sysctl.conf` uncomment `net.ipv4.ip_forward=1`
- add file `/etc/modules-load.d/k8s.conf`
    ```
    br_netfilter
    ```
-  reboot
- Create directory `/etc/apt/keyrings`
- Add kubernetes keyring
    ```bash
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    ```
- Add repo source list
    ```bash
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    ```
- Install kubernetes
    ```bash
    sudo apt install -y kubeadm kubectl kubelet
    ```
- Install kubernetes cluster
    ```bash
    sudo kubeadm init --apiserver-advertise-address=192.168.56.10 --apiserver-cert-extra-sans=192.168.56.10 --control-plane-endpoint=192.168.56.10 --node-name k8s-master --pod-network-cidr=10.244.0.0/16
    ```

- Execute this
    ```bash
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    ```
- Install network overlay
    ```bash
    kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
    ```

- Get kubeadmin join command
    ```bash
    sudo kubeadm token create --print-join-command
    ```

- Join node to master
    ```bash
    sudo kubeadm join 192.168.56.10:6443 --token 882dcm.kp9492zzckta1mgb --discovery-token-ca-cert-hash sha256:24dfcf2f83386ef2056a4b2ba7964e5582c8b9bbce8418a32ebe5b8af2050be8
    ```