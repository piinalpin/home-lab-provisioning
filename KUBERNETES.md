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

#### Deploy Tempo

```bash
helm -n monitoring install tempo grafana/tempo -f ./service/monitoring/tempo/values.yaml
```
**Add Tempo to Grafana Datasource**
Select new datasource `Tempo` and set url to `http://tempo:3100`

#### Deploy loki

Create directory `/run/promtail`
```bash
sudo mkdir /run/promtail && sudo chown -R $(whoami) /run/promtail && ls /run && exit
```

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm -n monitoring install loki grafana/loki-stack -f ./service/monitoring/loki-stack/values.yaml --create-namespace
```

**Add Loki to Grafana Datasource**
Select new datasource `Loki` and set url to `http://loki:3100`

Add derived fields datasource
```text
name = trace_id
type = Regex in log line
regex = trace_id=(\w+)
query = ${__value.raw}
url label = View Trace

Turn on internal link select Datasource Tempo
```

### Reference
- [Promtail Output](https://grafana.com/docs/loki/latest/send-data/promtail/stages/output/)

### Grafana Dashboard
```bash
https://grafana.com/grafana/dashboards/11378-justai-system-monitor/
https://grafana.com/grafana/dashboards/1860-node-exporter-full/
https://grafana.com/grafana/dashboards/13659-blackbox-exporter-http-prober/
```