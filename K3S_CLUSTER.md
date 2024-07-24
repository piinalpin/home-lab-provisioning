## Kubernetes Production Ready

Create k3s cluster using terraform and ansible:
```bash
terraform init
terraform plan
terraform apply --auto-approve
ansible-playbook -i inventory/homelab.hosts playbooks/k3s-playbook.yaml
```

### Install Load Balancer (MetalLB)

Install Helm [here](https://helm.sh/docs/intro/install/)

Add helm repository
```bash
helm repo add metallb https://metallb.github.io/metallb
```

Install `MetalLB`
```bash
helm install metallb metallb/metallb -n metallb-system --create-namespace
```

Apply manifest address pool, will provide adresses `192.168.56.51-192.168.56.254`

```bash
kubectl apply -f .config/cluster/metallb/ipaddresspool.yaml
```

Apply manifest L2 Advertisement for default pool

```bash
kubectl apply -f .config/cluster/metallb/l2advertisement.yaml
```

## Install Kong
Add gateway CRD
```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml
```

Create `gatewayclass` and `gateway`
```bash
kubectl apply -f ./config/cluster/kong/gatewayclass.yaml 
```

Install kong
```bash
helm -n kong-gateway install kong kong/ingress  --create-namespace
```
Update `/etc/hosts`

## Install Ceph with Rook

```bash
helm repo add rook-release https://charts.rook.io/release
helm -n rook-ceph install rook-ceph rook-release/rook-ceph --create-namespace
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.14/deploy/examples/cluster.yaml
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.14/deploy/examples/operator.yaml
```

Installl storage class and ceph block pool
```bash
helm -n rook-ceph install ceph-block-pool ./service/storage-class -f ./service/storage-class/values.yaml
```

Create directory on each virtual machine because we will use local storage
```bash
mkdir -p database/postgresql
```