### Install rook-ceph cluster

```bash
helm repo add rook-release https://charts.rook.io/release
helm install --namespace rook-ceph rook-release/rook-ceph
```

### Create ceph storage class

```bash
helm -n rook-ceph install rook-ceph-storage-class ./storage-class --create-namespace
```