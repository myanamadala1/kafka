#!/bin/bash

#set -x

KAFKA_REST_BASE_URL="${1}"
KAFKA_TOPIC="${2}"

curl -L -k -X POST -H "Content-Type: application/vnd.kafka.v2+json" --data '{"name": "my_consumer_instance", "format": "json", "auto.offset.reset": "earliest"}' "${KAFKA_REST_BASE_URL}/consumers/my_json_consumer1"
curl -L -k -X POST -H "Content-Type: application/vnd.kafka.v2+json" --data "{\"topics\":[\"${KAFKA_TOPIC}\"]}" "${KAFKA_REST_BASE_URL}/consumers/my_json_consumer1/instances/my_consumer_instance/subscription"

for (( ; ; ))
do
   curl -L -k -X GET -H "Accept: application/vnd.kafka.json.v2+json" "${KAFKA_REST_BASE_URL}/consumers/my_json_consumer1/instances/my_consumer_instance/records"
   echo -e "\n"
   sleep 5
done


curl -L -k -X DELETE -H "Content-Type: application/vnd.kafka.v2+json" "${KAFKA_REST_BASE_URL}/consumers/my_json_consumer/instances/my_consumer_instance"
