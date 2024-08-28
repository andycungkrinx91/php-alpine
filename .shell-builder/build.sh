#!/bin/bash
if [ -z "$1" ] ; then
        echo 'pipeline are setuped incorrectly'
        exit 1
fi

#!/bin/bash
REGISTRY_URL="https://index.docker.io/v1/"
USERNAME="andycungkrinx91"
TOKEN="dckr_pat_OrkhS3nuOkG1bHCjqQRk2o4oMDc"

bid=$(date +%Y-%m-%d)
githead=$(git rev-parse HEAD)
set -ex
echo "Building Backend Docker image with tag " $$githead-$$bid

docker login $REGISTRY_URL -u $USERNAME -p $TOKEN

# Build apps image
docker build -t andycungkrinx91/php-alpine:$1 -f php-$1.build . --no-cache
docker push andycungkrinx91/php-alpine:$1
docker tag andycungkrinx91/php-alpine:$1 andycungkrinx91/php-alpine:latest
docker push andycungkrinx91/php-alpine:latest