#!/bin/bash

#set -x

KAFKA_REST_BASE_URL="${1}"
KAFKA_TOPIC="${2}"
KAFKA_GROUP="${3}"
KAFKA_INSTANCE="${4}"

curl -L -k -X POST -H "Content-Type: application/vnd.kafka.v2+json" --data "{\"name\": \"${KAFKA_INSTANCE}\", \"format\": \"json\", \"auto.offset.reset\": \"earliest\"}" "${KAFKA_REST_BASE_URL}/consumers/${KAFKA_GROUP}"
curl -L -k -X POST -H "Content-Type: application/vnd.kafka.v2+json" --data "{\"topics\":[\"${KAFKA_TOPIC}\"]}" "${KAFKA_REST_BASE_URL}/consumers/${KAFKA_GROUP}/instances/${KAFKA_INSTANCE}/subscription"

for (( ; ; ))
do
   curl -L -k -X GET -H "Accept: application/vnd.kafka.json.v2+json" "${KAFKA_REST_BASE_URL}/consumers/${KAFKA_GROUP}/instances/${KAFKA_INSTANCE}/records"
   echo -e "\n"
   sleep 5
done

curl -L -k -X DELETE -H "Content-Type: application/vnd.kafka.v2+json" "${KAFKA_REST_BASE_URL}/consumers/${KAFKA_GROUP}/instances/${KAFKA_INSTANCE}"
