#!/bin/echo docker build . -f
# -*- coding: utf-8 -*-
#{
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/ .
#}

FROM debian:buster
LABEL maintainer="rzr@users.sf.net"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG ${LC_ALL}

RUN echo "#log: Configuring locales and setting up system" \
  && set -x \
  && apt update \
  && apt install -y locales sudo \
  && echo "${LC_ALL} UTF-8" | tee /etc/locale.gen \
  && locale-gen ${LC_ALL} \
  && dpkg-reconfigure locales \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && sync

ENV project mozilla-iot-deb

workdir /usr/local/opt/${project}/src/${project}
ADD . ${workdir}
WORKDIR ${workdir}
RUN echo "#log: ${project}: Preparing sources" \
  && set -x \
  && ./build.sh \
  && sync
