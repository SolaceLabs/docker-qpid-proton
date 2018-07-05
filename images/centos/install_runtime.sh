#!/usr/bin/env bash

# add rpm repository
rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# install build tools and language environments
yum -y install gcc gcc-c++ make openssl ruby
