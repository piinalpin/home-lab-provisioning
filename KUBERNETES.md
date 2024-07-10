## Configure Kubernetes

Prerequisities:
- Helm
- Kubectl

### Install Postgresql
```bash
helm -n postgresql install postgresql ./service/postgresql --debug --create-namespace 
```

### Install Keycloak
```bash
helm -n keycloak install keycloak ./service/keycloak --debug --create-namespace 
```

Add hosts in `/etc/hosts`
```bash
192.168.56.101	keycloak.piinalpin.lab
```