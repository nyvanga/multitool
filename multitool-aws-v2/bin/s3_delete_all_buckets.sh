#!/bin/bash

set -euo pipefail

BUCKET_NAMES="$(aws s3api list-buckets | jq -r '.Buckets | .[].Name' | sort)"

for BUCKET_NAME in ${BUCKET_NAMES}; do
  echo "${BUCKET_NAME}"
done
echo
echo -n "Are you sure? All of the above S3 buckets will be emptied and deleted [yes/NO]: "
read YES_NO


if [[ "${YES_NO:-}" == "yes" ]]; then
  for BUCKET_NAME in ${BUCKET_NAMES}; do
    echo "Emptying bucket '${BUCKET_NAME}'"
    s3_delete_all_versions.py "${BUCKET_NAME}"
    echo "Deleting bucket '${BUCKET_NAME}'"
    aws s3api delete-bucket --bucket "${BUCKET_NAME}"
  done
fi
