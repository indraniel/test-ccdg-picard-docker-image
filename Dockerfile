FROM ubuntu:14.04
MAINTAINER Indraniel Das <idas@wustl.edu>

# Volumes
VOLUME /build
VOLUME /release

# bootstrap build dependencies
# Concatentating these command together will create only 1 docker image layer
# fewer image layers are better / smaller
RUN apt-get update -qq && \
    apt-get -y install apt-transport-https && \
    echo "deb [trusted=yes] https://gitlab.com/indraniel/ccdg-apt-repo/raw/master ccdg main" | tee -a /etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get -y install \
    libnss-sss \
    ccdg-picard-2.4.1 \
    cowsay \
    --no-install-recommends && \
    apt-get clean all
