### Create Self Signed Certificate
```bash
openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) -keyout keycloak.key -out keycloak.crt -days 1095 \
-subj "/C=ID/ST=Yogyakarta/L=Yogyakarta/O=Homelab Ltd./OU=Homelab/CN=keycloak.piinalpin.lab"
```

### Create TLS Secret
```bash
kubectl create secret tls keycloak-piinalpin-lab-cert --cert=keycloak.crt --key=keycloak.key --namespace keycloak
```

### Install with helm
```bash
helm install keycloak services/keycloak -n keycloak
```