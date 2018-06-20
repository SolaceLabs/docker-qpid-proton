#!/usr/bin/env bash
PRG_DIR=`dirname ${BASH_SOURCE[0]}`
# common helper functions
source $PRG_DIR/helper.sh
# useful helper functions

docker_image_remove() {
    local DOCKER_REPO=$1
    shift
    while [ "$1" ]; do 
        local TAGS="$TAGS $1"
        shift
    done
    for TAG in $TAGS; do
        local DOCKER_IMAGE=$DOCKER_REPO:$TAG
        if [ "`docker image ls $DOCKER_IMAGE -q`" ]; then
            echo "removing image $DOCKER_IMAGE"
            docker image rm -f $DOCKER_IMAGE
            docker image prune -f
        else
            echo "could not find docker image $DOCKER_IMAGE locally"
        fi
    done
}

echo "checking docker cmd"

check_docker

docker_registry $1
shift

docker_image_remove $DOCKER_REGISTRY ubuntu centos latest $@
