#!/bin/bash
if [ -z "$1" ] ; then
        echo 'pipeline are setuped incorrectly'
        exit 1
fi

docker build -t registry.gitlab.com/andycungkrinx/php-alpine:$1 -f php-$1.build .
docker push registry.gitlab.com/andycungkrinx/php-alpine:$1