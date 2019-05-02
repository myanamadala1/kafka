#!/bin/bash

#set -x

KAFKA_REST_BASE_URL="${1}"
KAFKA_TOPIC="${2}"
INPUT="${3:-./dealer-flat.json}"

while IFS= read -r var
do
  data="{\"records\":[{\"value\":${var}}]}"
  curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" -H "Accept: application/vnd.kafka.v2+json" --data "${data}" "${KAFKA_REST_BASE_URL}/topics/${KAFKA_TOPIC}"
  echo -e "\n"
  sleep 0.5
done < "$INPUT"

