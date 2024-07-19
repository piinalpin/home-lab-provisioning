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

### Deploy Monitoring

#### Install monitoring config
- Persistence Volume
- Grafana ingress

```bash
helm -n monitoring install monitoring-config ./service/monitoring/00-config --create-namespace
```

#### Deploy Kube Prometheus Grafana
- Prometheus
- Grafana
- Alert Monitoring

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 
helm repo update
helm -n monitoring install kube-prometheus prometheus-community/kube-prometheus-stack -f .service/monitoring/kube-prom/values.yaml --create-namespace
```

Login grafana with username `admin` and password `prom-operator`

#### Deploy loki

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm -n monitoring install loki grafana/loki-stack -f ./service/monitoring/loki-stack/values.yaml --create-namespace
```

### Grafana Dashboard
```bash
https://grafana.com/grafana/dashboards/11378-justai-system-monitor/
https://grafana.com/grafana/dashboards/1860-node-exporter-full/
https://grafana.com/grafana/dashboards/13659-blackbox-exporter-http-prober/
```