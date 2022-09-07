#! /usr/bin/env sh

# Exit in case of error
set -e

DOMAIN=${DOMAIN?Domain not set} \
TRAEFIK_TAG=${TRAEFIK_TAG?TRAEFIK_TAG not set} \
STACK_NAME=${STACK_NAME?STACK_NAME not set} \
TAG=${TAG?Tag not set} \
docker-compose \
-f docker-compose.yml \
config > docker-stack.yml

docker-auto-labels docker-stack.yml

docker stack deploy -c docker-stack.yml --with-registry-auth "${STACK_NAME?STACK_NAME not set}"
