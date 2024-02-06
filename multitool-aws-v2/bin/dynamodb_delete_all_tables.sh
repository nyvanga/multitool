#!/bin/bash

set -euo pipefail

DYNAMODB_TABLE_NAMES="$(aws dynamodb list-tables | jq -r '.TableNames | .[]' | sort)"

for DYNAMODB_TABLE_NAME in ${DYNAMODB_TABLE_NAMES}; do
  echo "${DYNAMODB_TABLE_NAME}"
done
echo
echo -n "Are you sure? All of the above DynamoDB tables will be deleted [yes/NO]: "
read YES_NO


if [[ "${YES_NO:-}" == "yes" ]]; then
  for DYNAMODB_TABLE_NAME in ${DYNAMODB_TABLE_NAMES}; do
    echo "Deleting DynamoDB table '${DYNAMODB_TABLE_NAME}'"
    aws dynamodb delete-table --table "${DYNAMODB_TABLE_NAME}"
  done
fi
