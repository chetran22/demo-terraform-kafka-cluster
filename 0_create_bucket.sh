#!/bin/bash


DIR=$1

if [[ $# -ne 1 ]]; then
  echo "Usage : <ENV_DIR>"
  echo "$0 ada-nonprod/us-east-1/dev1"
  exit 1
fi

bucket=$(cat ${DIR}/* | grep ^bucket | awk '{print $3}' | sed 's/"//g')
region=$(cat ${DIR}/* | grep ^aws_region | awk '{print $3}' | sed 's/"//g')

echo aws s3api create-bucket --bucket "$bucket" --region "${region}"
echo sleeping 5...
sleep 5

# create bucket
aws s3api create-bucket --bucket ${bucket} --region ${region}

# block bucket from public
aws s3api put-public-access-block \
    --bucket ${bucket} \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
