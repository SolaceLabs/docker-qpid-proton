#!/usr/bin/env bash
# build the qpid proton container images using docker

# navigate to images directory
PRG_DIR=`dirname ${BASH_SOURCE[0]}`

source $PRG_DIR/helper.sh

IMAGES_DIR=$PRG_DIR/../images

cd $IMAGES_DIR

# build and tag docker container images
check_docker

docker_registry $1
shift

echo "Docker registry: $DOCKER_REGISTRY"

# build and tag ubuntu runtime container image
docker build -t ${DOCKER_REGISTRY}:ubuntu -t ${DOCKER_REGISTRY}:latest --build-arg OS=ubuntu --build-arg INSTALL_DIR=/usr/lib -f Dockerfile .

# build and tag ubuntu proton build container image
docker build -t ${DOCKER_REGISTRY}:ubuntu_build --build-arg OS=ubuntu --build-arg INSTALL_DIR=/usr/lib -f Dockerfile --target build .

# build and tag centos runtime container image
docker build -t ${DOCKER_REGISTRY}:centos --build-arg OS=centos --build-arg INSTALL_DIR=/usr/lib64 -f Dockerfile .

# build and tag centos proton build container image
docker build -t ${DOCKER_REGISTRY}:centos_build --build-arg OS=centos --build-arg INSTALL_DIR=/usr/lib64 -f Dockerfile --target build .

