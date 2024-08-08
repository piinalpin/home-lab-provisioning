### Create TLS Certificate
```bash
kubectl apply -f .config/cluster/certificates/keycloak.yaml
```

### Install with helm
```bash
helm install keycloak services/keycloak -n keycloak
```