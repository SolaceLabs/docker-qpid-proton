#!/usr/bin/env bash

# install all dependencies to qpid proton from source on centos

# see <proton_src_dir>/INSTALL.md for details

# update 
yum -y update
# install qpid proton build tools uuid lib dependency
yum -y install gcc gcc-c++ make cmake libuuid-devel
# install ssl dependency
yum -y install openssl-devel
# install SASL dependency
yum -y install cyrus-sasl-devel cyrus-sasl-plain cyrus-sasl-md5
# install language binding dependencies
yum -y install swig python-devel ruby-devel rubygem-minitest
