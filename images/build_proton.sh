#!/usr/bin/env bash
PRG_DIR=`dirname BASH_SOURCE[0]`
PROTON_SRC_DIR=$PRG_DIR/lib/qpid-proton-${PROTON_VERSION}
PROTON_BUILD_DIR=$PROTON_SRC_DIR/build
mkdir -p $PROTON_BUILD_DIR

cd $PROTON_BUILD_DIR

if [ "$1" ]; then
    CMAKE_SWITCHS=$1
fi

cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DSYSINSTALL_BINDINGS=ON $CMAKE_SWITCHS 

make all install
