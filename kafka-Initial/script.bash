#!/bin/bash
set -x;

KAFKA_TOPICS=${1:-nggarage}
KAFKA_GROUP=${2:-group1}
KAFKA_REST_HOST="https://ng-garage-nafta-qa.app.corpintra.net"
KAFKA_VERSION="v2"

curl -X POST -H "Content-Type: application/vnd.kafka.json.${KAFKA_VERSION}+json" -H "Accept: application/vnd.kafka.${KAFKA_VERSION}+json"       --data '{"records":[{"value":{"foo":"bar"}}]}' "${KAFKA_REST_HOST}/topics/${KAFKA_TOPICS}" -k -L
curl -X POST -H "Content-Type: application/vnd.kafka.${KAFKA_VERSION}+json" --data "{\"name\": \"${KAFKA_GROUP}\", \"format\": \"json\", \"auto.offset.reset\": \"smallest\"}" ${KAFKA_REST_HOST}/consumers/my_json_consumer -k -L
curl -X POST -H "Content-Type: application/vnd.kafka.${KAFKA_VERSION}+json" --data "{\"topics\":[\"${KAFKA_TOPICS}\"]}" ${KAFKA_REST_HOST}/consumers/my_json_consumer/instances/${KAFKA_GROUP}/subscription -k -L
curl -X GET -H "Accept: application/vnd.kafka.json.${KAFKA_VERSION}+json" ${KAFKA_REST_HOST}/consumers/my_json_consumer/instances/${KAFKA_GROUP}/records -k -L