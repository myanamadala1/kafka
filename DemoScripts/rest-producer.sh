#!/bin/bash

#set -x

KAFKA_REST_BASE_URL="${1}"
KAFKA_TOPIC="${2}"

input="./dealer-flat.json"
while IFS= read -r var
do
  data="{\"records\":[{\"value\":${var}}]}"
  curl -L -k -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" -H "Accept: application/vnd.kafka.v2+json" --data "${data}" "${KAFKA_REST_BASE_URL}/topics/${KAFKA_TOPIC}"
  echo -e "\n"
#  sleep 1
done < "$input"

#DEALER_ID=$((1 + RANDOM % 10))
#echo "DEALER_ID is ${DEALER_ID}"
