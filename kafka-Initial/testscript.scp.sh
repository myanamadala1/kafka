cat <<'EOT'>> test.sh
#!/bin/bash
set -x;

KAFKA_TOPIC=${1}
KAFKA_CONSUMER=${2}
KAFKA_CONSUMER_INSTANCE=${3}
KAFKA_REST_HOST="${4:-http://my-confluent-oss-cp-kafka-rest:8082}"
KAFKA_VERSION="v2"

curl -X POST -H "Content-Type: application/vnd.kafka.json.${KAFKA_VERSION}+json" -H "Accept: application/vnd.kafka.${KAFKA_VERSION}+json"       --data '{"records":[{"value":{"foo":"bar"}}]}' "${KAFKA_REST_HOST}/topics/${KAFKA_TOPIC}" -k -L
curl -X POST -H "Content-Type: application/vnd.kafka.${KAFKA_VERSION}+json" --data "{\"name\": \"${KAFKA_CONSUMER_INSTANCE}\", \"format\": \"json\", \"auto.offset.reset\": \"earliest\"}" ${KAFKA_REST_HOST}/consumers/${KAFKA_CONSUMER} -k -L
curl -X POST -H "Content-Type: application/vnd.kafka.${KAFKA_VERSION}+json" --data "{\"topics\":[\"${KAFKA_TOPIC}\"]}" ${KAFKA_REST_HOST}/consumers/${KAFKA_CONSUMER}/instances/${KAFKA_CONSUMER_INSTANCE}/subscription -k -L
curl -X GET -H "Accept: application/vnd.kafka.json.${KAFKA_VERSION}+json" ${KAFKA_REST_HOST}/consumers/${KAFKA_CONSUMER}/instances/${KAFKA_CONSUMER_INSTANCE}/records -k -L
EOT