# Product Import Engine

## Local Development Installation

### 1) Start Minikube
```
minikube start --memory 16384 --cpus 4 --network-plugin=cni --enable-default-cni
eval $(minikube docker-env)
```

### 2) Initialize Helm
```
kubectl create namespace pie
kubectl create serviceaccount tiller --namespace pie
kubectl create -f helm-charts/rbac/role-tiller.yaml
kubectl create -f helm-charts/rbac/rolebinding-tiller.yaml
helm init --service-account tiller --tiller-namespace pie --wait
```

### 3) Deploy Software Components
```
helm --tiller-namespace pie --namespace pie install helm-charts/confluent --name confluent 
helm --tiller-namespace pie --namespace pie install helm-charts/nifi --name nifi 
helm --tiller-namespace pie --namespace pie install helm-charts/elasticsearch --name elasticsearch
helm --tiller-namespace pie --namespace pie install helm-charts/kibana --name kibana
```

### 4) Deploy Data Flow
```
kubectl config set-context --current --namespace=${K8S_NS}
kubectl port-forward nifi-0 8080:8080

# in a new terminal
response=$(curl -F template=@helm-charts/nifi/flows/pie.xml http://localhost:8080/nifi-api/process-groups/root/templates/upload -L -k)
template=$(echo ${response}|sed -n 's:.*<id>\(.*\)</id>.*:\1:p')
data="{ \"originX\": 0.0, \"originY\": 0.0, \"templateId\": \"${template}\" }"
curl http://localhost:8080/nifi-api/process-groups/root/template-instance -H "Content-Type: application/json" -d "${data}"
open http://localhost:8080/nifi/
```

### Uninstalling
```
helm --tiller-namespace pie del --purge confluent
helm --tiller-namespace pie del --purge nifi
helm --tiller-namespace pie del --purge elasticsearch
helm --tiller-namespace pie del --purge kibana

```



## AWS EKS
Retrieve temporary credentials from https://int.logon.idp.aws.corpinter.net/Home/Cli
```
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_...
export AWS_SESSION_TOKEN=...
aws eks update-kubeconfig --name eks-nonprod
```

# SKIP THESE STEPS
## Docker
### Build local image to embed postgres
docker build -t confluentinc/cp-kafka-connect:5.2.1-debezium docker-images/cp-kafka-connect_debezium
### Build local image to comply with no-root policy
docker build -t confluentinc/cp-ksql-server:5.2.1-noroot docker-images/cp-ksql-server_rootless
