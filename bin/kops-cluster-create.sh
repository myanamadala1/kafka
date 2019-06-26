#!/bin/bash
set -e

DNS_ZONE=${1}
ENV_NAME=${2}
REGION=${3}
NODE_COUNT=${4:-3} # TODO should have both max and min size
NODE_SIZE=${5:-t2.2xlarge} # r4.xlarge -- only good for devops (not enough CPU for data processing clusters
MASTER_COUNT=${6:-3} # TODO should have both max and min size
MASTER_SIZE=${7:-t2.medium}

export KOPS_STATE_STORE="s3://kops.${DNS_ZONE}"

if [ ! -f id_rsa ]; then
    echo "┌────────────────────"
    echo "│ Generating SSH Key"
    echo "└────────────────────"

    ssh-keygen -f id_rsa -t rsa -N ''
fi

echo "DNS_ZONE:         ${DNS_ZONE}"
echo "ENV_NAME:         ${ENV_NAME}"
echo "REGION:           ${REGION}"
echo "NODE_COUNT:       ${NODE_COUNT}"
echo "NODE_SIZE:        ${NODE_SIZE}"
echo "MASTER_COUNT:     ${MASTER_COUNT}"
echo "MASTER_SIZE:      ${MASTER_SIZE}"
echo "KOPS_STATE_STORE: ${KOPS_STATE_STORE}"

case ${MASTER_COUNT} in
1) ZONES="${REGION}a" ;;
2) ZONES="${REGION}a,${REGION}b" ;;
3) ZONES="${REGION}a,${REGION}b,${REGION}c" ;;
*) ZONES="${REGION}a" ;;
esac

echo "ZONES:            ${ZONES}"

kops create cluster ${ENV_NAME}.${DNS_ZONE} \
  --authorization RBAC \
  --node-count ${NODE_COUNT} \
  --master-count ${MASTER_COUNT} \
  --dns-zone=${DNS_ZONE} \
  --api-loadbalancer-type public \
  --zones ${ZONES} \
  --node-size ${NODE_SIZE} \
  --master-size ${MASTER_SIZE} \
  --master-zones ${ZONES} \
  --networking weave \
  --topology private \
  --dns public \
  --bastion="false" \
  --ssh-public-key=id_rsa.pub \
  --state=${KOPS_STATE_STORE} \
  --logtostderr 
