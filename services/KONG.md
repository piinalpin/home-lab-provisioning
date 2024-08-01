### Generate Self Signed Certificate

Unix
```bash
openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) -keyout cluster.key -out cluster.crt -days 1095 -subj "/CN=kong_clustering"
```

Windows
```bash
openssl ecparam -name secp384r1 -out ecparam.pem
openssl req -new -x509 -nodes -newkey ec:ecparam.pem -keyout cluster.key -out cluster.crt -days 1095 -subj "/CN=kong_clustering"
Remove-Item ecparam.pem
```

### Create namespace
```bash
kubectl create namespace kong
```

### Apply TLS certificate to kubernetes secret
```bash
kubectl create secret tls kong-cluster-cert --cert=cluster.crt --key=cluster.key --namespace kong
```

### Create Kong Gateway Enterprice Lisence (Free Mode)
```bash
kubectl create secret generic kong-enterprise-license --from-literal=license="'{}'" -n kong
```

### Create Database Credential
```bash
kubectl create secret generic postgres-credential -n kong --from-literal=user=adminrnd --from-literal=password=gWl7Jj3eZbFEhBqg
```

### Apply Control Plane and Data Plane with Helm

```bash
helm install kong-cp kong/kong -n kong --values ./kong/values-cp.yaml
helm install kong-cp kong/kong -n kong --values ./kong/values-dp.yaml
```