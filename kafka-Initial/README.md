```console
# start minikube with CNI network plugin
minikube --network-plugin=cni start

# install Weave networking
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# makes minikube use local docker daemon
eval $(minikube docker-env)

docker pull gcr.io/google_samples/k8szk:v3
docker tag gcr.io/google_samples/k8szk:v3 reg-dhc-americas.app.corpintra.net/myanama/zookeeper:3.4.10
docker push reg-dhc-americas.app.corpintra.net/myanama/zookeeper:3.4.10

docker pull confluentinc/cp-kafka:5.0.1
docker tag confluentinc/cp-kafka:5.0.1 reg-dhc-americas.app.corpintra.net/myanama/kafka:2.0.0
docker push reg-dhc-americas.app.corpintra.net/myanama/kafka:2.0.0

docker pull docker.elastic.co/elasticsearch/elasticsearch:6.6.1
docker tag docker.elastic.co/elasticsearch/elasticsearch:6.6.1 reg-dhc-americas.app.corpintra.net/myanama/elasticsearch:6.6.1
docker push reg-dhc-americas.app.corpintra.net/myanama/elasticsearch:6.6.1

docker pull docker.elastic.co/kibana/kibana:6.6.1
docker tag docker.elastic.co/kibana/kibana:6.6.1 reg-dhc-americas.app.corpintra.net/myanama/kibana:6.6.1
docker push reg-dhc-americas.app.corpintra.net/myanama/kibana:6.6.1

docker pull apache/nifi:1.8.0
docker tag apache/nifi:1.8.0 reg-dhc-americas.app.corpintra.net/myanama/nifi:1.8.0
docker push reg-dhc-americas.app.corpintra.net/myanama/nifi:1.8.0

# create namespace garagetest
kubectl apply -f 00-namespace.yaml

# set garagetest as default namespace
kubectl config set-context $(kubectl config current-context) --namespace=garagetest

# deploy Zookeeper
kubectl apply -f 10-zookeeper.yaml

# deploy Kafka
kubectl apply -f 20-kafka.yaml

# deploy Elasticsearch
kubectl apply -f 30-elasticsearch.yaml

# deploy Kibana
kubectl apply -f 40-kibana.yaml

# deploy NiFi
kubectl apply -f 50-nifi.yaml


tail -f /var/log/system.log | cut -c 17-| while read LINE ; do (curl -i http://192.168.99.107:30090/events -XPOST -H "Content-Type: application/json" -d "{\"message\":\"${LINE}\"}") ; done


tail -f /var/log/system.log | while read LINE ; do (curl -i http://192.168.99.107:30090/events -XPOST -H "Content-Type: application/json" -d '{"message":"hello world!"}') ; done


tail -f /var/log/system.log | sed -e "s/\"//g" |  awk '{print "{\"message\":\""$0"\"}"}'|while read LINE ; do (echo "$LINE") ; done


tail -F /var/log/system.log | sed -e "s/\"//g" |  awk '{print "{\"message\":\""$0"\"}"}'|while read LINE ; do (curl -X POST -H "Content-Type: application/json"  http://192.168.99.107:30090/events -d "$LINE") ; done


tail -F /var/log/system.log | sed -e "s/\"//g" |  awk '{print "{\"message\":\""$0"\"}"}'|while read LINE ; do (echo "$LINE") ; done

```