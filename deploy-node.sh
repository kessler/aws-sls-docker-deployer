#!/bin/sh

# check that AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are set
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set"
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set"
  exit 1
fi

echo "sls params are: \"$@\""
cd /app
echo "re-installing node modules..."
rm -rf node_modules
npm install --omit=dev
echo "npm install complete"

sls deploy $@
