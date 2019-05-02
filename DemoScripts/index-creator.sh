#!/bin/bash

ELASTICSEARCH_BASE_URL="${1}"

curl -XPUT "${ELASTICSEARCH_BASE_URL}/dealers?pretty" -H 'Content-Type: application/json' -d '{"mappings": {"dealer": {"properties": {"timestamp": { "type": "date" }, "location": { "type": "geo_point" }}}}}'
curl -XPUT "${ELASTICSEARCH_BASE_URL}/messages?pretty" -H 'Content-Type: application/json' -d '{"mappings": {"message": {"properties": {"timestamp": { "type": "date" }}}}}'