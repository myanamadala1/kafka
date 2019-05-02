#!/bin/bash

#set -x

KAFKA_REST_BASE_URL="${1}"
KAFKA_TOPIC="${2}"
input="${3:-dealer-mx-flat.json}"
type="${4:-json}"
while IFS= read -r var
do
if [ "${type}" == "binary" ]; then
                echo "encoding..."
                var=$(echo -ne "${var}" | base64);
                data="{\"records\":[{\"value\":\"${var}\"}]}"
        else
                echo "not encoding..."
		data="{\"records\":[{\"value\":${var}}]}"
        fi

        echo "Data after ${data}"
  curl -k -X POST -H "Content-Type: application/vnd.kafka.${type}.v2+json" -H "Accept: application/vnd.kafka.v2+json" --data "${data}" "${KAFKA_REST_BASE_URL}/topics/${KAFKA_TOPIC}"
  echo -e "\n"
  sleep 1
done < "$input"

#DEALER_ID=$((1 + RANDOM % 10))
#echo "DEALER_ID is ${DEALER_ID}"
