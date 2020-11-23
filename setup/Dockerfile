# SPDX-License-Identifier: AGPL-3.0
# Copyright (C) 2020 Coooooooozy

FROM debian:10

ENV DEBIAN_FRONTEND=noninteractive

## Generate locale
ARG lang=0
RUN apt-get update  -y \
 && apt-get install -y --no-install-recommends \
    fonts-noto-cjk \
    locales    
RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && echo "${lang} UTF-8" >> /etc/locale.gen
RUN locale-gen ${lang}
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN /usr/sbin/update-locale LANG=${lang}

## Common packages for linux
RUN apt-get update  -y \
 && apt-get install -y --no-install-recommends \
    apt-transport-https \
    curl \
    git \
    gnupg \
    nano \
    openjdk-11-jdk \
    openjdk-11-jdk-headless \
    software-properties-common

## Clean up
RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=

## Setup build user
ARG gid=0
ARG uid=0
RUN groupadd -g ${gid} craft
RUN useradd \
    --gid craft \
    --uid ${uid} \
    --shell /bin/bash \
    --home /home/builder \
    --create-home \
    builder

## Setup develop environment
USER builder
WORKDIR /home/builder
RUN mkdir -p /home/builder/workspace

# Ignore root
USER root
RUN usermod -L root
USER builder

CMD bash
