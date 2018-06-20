#!/usr/bin/env bash

# publishes docker images

# navigate to images directory
PRG_DIR=`dirname ${BASH_SOURCE[0]}`

# common helper function
source $PRG_DIR/helper.sh

# useful helper functions
docker_login() {
    # login to docker registry

    if ! [ "`docker info | grep Username`" ]; then
        echo "User not logged into docker resgistry"
        echo "Please login"
        docker login
    fi
}


docker_publish() {
    # base docker registery name
    local DOCKER_REPO=$1
    shift
    # all tags to publish
    while [ "$1" ]; do
        local TAGS="$TAGS $1"
        shift
    done
    for TAG in $TAGS; do
        if [ "`docker image ls $DOCKER_REPO:$TAG -q`" ]; then
            echo "docker push $DOCKER_REPO:$TAG"
            docker push $DOCKER_REPO:$TAG || echo "failed to push docker image $DOCKER_REPO:$TAG"
        else
            echo "Can not push docker image $DOCKER_REPO:$TAG that does not exist"
        fi
    done
}

# check docker cmd
check_docker

# check user login to docker registry
docker_login

# create docker image name base (docker registry)
docker_registry $1
shift

# publish docker images to registry
docker_publish $DOCKER_REGISTRY latest $@
