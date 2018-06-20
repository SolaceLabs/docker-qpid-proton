# have proton version and os parameterized
ARG OS=ubuntu
ARG PROTON_VERSION=0.23.0
# create base OS image
FROM ${OS}:latest as base

# have proton version and os parameterized
ARG OS=ubuntu
ARG PROTON_VERSION=0.23.0
# add proton version and os parameters added to environment varibles
ENV OS=${OS} PROTON_VERSION=${PROTON_VERSION} PATH=${PATH}:.

WORKDIR /sample

ADD ./Dockerfile /sample/

# add os specific dependency installer scripts
ADD ./${OS}/*.sh /sample/

# create build image to build qpid proton
FROM base as build

# add build script to image
ADD ./build_proton.sh /sample/

# installs proton library build dependencies for specific OS
RUN chmod 755 ./install_build.sh && install_build.sh

# downloads qpid proton source 
RUN mkdir -p /sample/lib && \
    cd lib && \
    curl -L http://apache.mirror.iweb.ca/qpid/proton/${PROTON_VERSION}/qpid-proton-${PROTON_VERSION}.tar.gz > qpid-proton-${PROTON_VERSION}.tar.gz && \
    tar xvf qpid-proton-${PROTON_VERSION}.tar.gz && \
    rm -f qpid-proton-${PROTON_VERSION}.tar.gz

# builds qpid proton library
RUN  chmod 755 ./build_proton.sh && build_proton.sh

# create light weight runtime image with only developer tools and qpid proton library installed
FROM base as runtime

# installs proton library runtime dependencies for specific OS
RUN  chmod 755 ./install_runtime.sh && install_runtime.sh

# copy installed proton libraries from build image
# The INSTALL_DIR can change depending on the OS 
# Make parameter for different OS default to ubuntu location
ARG INSTALL_DIR=/usr/lib
# copy qpid proton libraries
COPY --from=build ${INSTALL_DIR}/*qpid* ${INSTALL_DIR}/
# copy qpid proton headers
COPY --from=build /usr/include/proton /usr/include/proton

