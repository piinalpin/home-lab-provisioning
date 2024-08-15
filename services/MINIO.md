### Create Namespace
```bash
kubectl create namespace storage
```

### Create TLS Certificate
```bash
kubectl apply -f .config/cluster/certificates/selfsigned-root.yaml
kubectl apply -f .config/cluster/certificates/minio-operator.yaml
kubectl apply -f .config/cluster/certificates/minio-tenant.yaml
```

### Add persistence volume
```bash
kubectl apply -f ./services/minio/pv.yaml
```

### Install with helm
```bash
helm install minio minio-operator/operator -f ./services/minio/operator.yaml -n storage
helm install minio minio-operator/tenant -f ./services/minio/tenant.yaml -n storage
```