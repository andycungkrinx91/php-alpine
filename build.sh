#!/bin/bash
docker build -t registry.gitlab.com/andycungkrinx/php-alpine:7.3 .
docker push registry.gitlab.com/andycungkrinx/php-alpine:7.3
