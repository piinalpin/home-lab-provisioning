## ECK Stack

Deploy custom resource definition

```bash
kubectl create -f https://download.elastic.co/downloads/eck/2.5.0/crds.yaml
```

Apply elasticsearch operator to provision elastic stack
```bash
kubectl apply -f https://download.elastic.co/downloads/eck/2.5.0/operator.yaml
```

Add helm repository
```bash
helm repo add elastic https://helm.elastic.co
helm repo update
```

Install Elasticsearch and Kibana
```bash
helm install es-kb-quickstart elastic/eck-stack -n elastic-stack --create-namespace
```

Install elasticsearch individual
```bash
helm install elasticsearch elastic/eck-stack -n elastic-stack --create-namespace --set=eck-kibana.enabled=false
```

or modify `values.yaml` set `eck-kibana.enabled: false`
```bash
helm install elasticsearch elastic/eck-stack -n elastic-stack -f ./services/elastic-stack/values.yaml--create-namespace
```