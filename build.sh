#!/bin/bash
docker build -t registry.gitlab.com/andycungkrinx/php-alpine:7.4 .
docker push registry.gitlab.com/andycungkrinx/php-alpine:7.4
