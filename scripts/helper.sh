#!/usr/bin/env bash

check_tool() {
    [ "`command -v $1`" ]
}

check_docker() {
    if ! check_tool docker; then
        echo "the docker command was not found"
        echo "please install docker and make command available"
        exit 1
    fi
}

docker_registry() {
    # make image tag name base
    if [ "$1" ]; then
        if [ "$1" == "local" ] || [ "$1" == "$USER" ]; then
            local DOCKER_USERNAME="$USER"
        elif [ "$1" == "release" ]; then
            local DOCKER_USERNAME="solace"
        else
            local DOCKER_USERNAME="$1"
        fi
    else
        local DOCKER_USERNAME="solace"
    fi
    shift

    DOCKER_REGISTRY=${DOCKER_USERNAME}/docker-qpid-proton
}
