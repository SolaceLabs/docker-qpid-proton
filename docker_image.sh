#!/usr/bin/env bash

# helper functions
script_init(){
    PRG="$1"
    # Attempt to set APP_HOME
    # Resolve links: $0 may be a link
    # Need this for relative symlinks.
    local SOURCE=$PRG
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        local DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        local SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    # set global variable for path to executing script
    PRG_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    PRG=`basename $PRG`

}

help(){
    echo "$PRG [options] <command> [<args...>]"
    echo "    build:                builds the docker images"
    echo "    clean [<tag>...]:     removes the docker images"
    echo "    publish [<tag>...]:   publishes the docker images"
    echo "    help:                 displays this message"
    echo "options:"
    echo "    -u <username>: specifies username for docker registry, default:'solace'"
}

run_command(){
    local COMMAND=$1
    shift
    if [ "$DOCKER_USERNAME" ]; then
        local REGISTRY_USER=$DOCKER_USERNAME
    else
        # the release USER uses the default release user 'solace' in the command scripts
        local REGISTRY_USER="release"
    fi
    if [ "$COMMAND" == "build" ]; then
        $SCRIPT_HOME/build.sh $REGISTRY_USER || echo "Failed build docker image command"
    elif [ "$COMMAND" == "clean" ]; then
        # determine tags from arguments
        while [ "$1" ]; do
            # add all tags from build.sh for argument 'all'
            if [ "$1" == "all" ]; then
                local TAGS="$TAGS centos ubuntu centos_build ubuntu_build"
            else 
                local TAGS="$TAGS $1"
            fi
            shift
        done
        $SCRIPT_HOME/clean.sh $REGISTRY_USER $TAGS || echo "Failed clean docker image command"
    elif [ "$COMMAND" == "publish" ]; then
        # determine tags from arguments
        while [ "$1" ]; do
            local TAGS="$TAGS $1"
            shift
        done

        $SCRIPT_HOME/publish.sh $REGISTRY_USER || echo "Failed publish docker image command"
    elif [ "$COMMAND" == "help" ]; then
        help
    else
        echo "Unrecognized command: $COMMAND"
        echo "Usage:"
        help
    fi
}

# script Start

# setup location variables using absolute paths
script_init ${BASH_SOURCE[0]}

SCRIPT_HOME=$PRG_DIR/scripts

# import common resources
source $SCRIPT_HOME/helper.sh

# parse options
if [ "$1" == "-u" ]; then
    shift 
    DOCKER_USERNAME=$1
    shift
fi 

# check for docker tool
check_docker

# parse and run command from arguments
run_command $@
