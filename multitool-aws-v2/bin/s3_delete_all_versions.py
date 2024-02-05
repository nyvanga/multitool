#!/usr/bin/env python3

import sys
import boto3

def s3_delete_all_versions(bucket_name):
  s3 = boto3.resource('s3')
  bucket = s3.Bucket(bucket_name)
  bucket.object_versions.all().delete()

if __name__ == '__main__':
  if len(sys.argv) < 2:
    print(f"Usage: {sys.argv[0]} <bucket name>")
  else:
    s3_delete_all_versions(sys.argv[1])
