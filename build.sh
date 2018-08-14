#!/usr/bin/env bash

set -e

docker version
docker-compose version

WORK_DIR=$(pwd)

if [ -n "${CI_OPT_DOCKER_REGISTRY_PASS}" ] && [ -n "${CI_OPT_DOCKER_REGISTRY_USER}" ]; then echo ${CI_OPT_DOCKER_REGISTRY_PASS} | docker login --password-stdin -u="${CI_OPT_DOCKER_REGISTRY_USER}" docker.io; fi

export IMAGE_PREFIX=${IMAGE_PREFIX:-infratop}
export IMAGE_NAME=${IMAGE_NAME:-jupyter-haskell}
export IMAGE_TAG=${IMAGE_TAG:-177037d09156}
if [ "${TRAVIS_BRANCH}" != "master" ]; then export IMAGE_TAG=${IMAGE_TAG}-SNAPSHOT; fi

# Build image
if [[ "$(docker images -q ${IMAGE_PREFIX}/${IMAGE_NAME}:${IMAGE_TAG} 2> /dev/null)" == "" ]]; then
    docker-compose -f docker-compose_${IMAGE_NAME}.yml build
fi








docker push ${IMAGE_PREFIX}/${IMAGE_NAME}:${IMAGE_TAG}
