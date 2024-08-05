### Install CRD
```bash
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/23.0.7/kubernetes/keycloaks.k8s.keycloak.org-v1.yml
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/23.0.7/kubernetes/keycloakrealmimports.k8s.keycloak.org-v1.yml
```

### Install Operator
```bash
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/23.0.7/kubernetes/kubernetes.yml -n keycloak
```

### Create DB Secret
```bash
kubectl create secret generic kc-postgres-credential -n keycloak --from-literal=user=adminrnd --from-literal=password=gWl7Jj3eZbFEhBqg
```