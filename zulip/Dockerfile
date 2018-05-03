FROM ubuntu:xenial
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

ENV ZULIP_VERSION 1.8.0
ENV DATA_DIR="/data" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"
ENV TERM linux

COPY custom_zulip_files/ /root/custom_zulip

RUN apt-get update && apt-get install -y \
    build-essential \
    crudini \
    curl \
    expect \
    git \
    locales \
    libffi-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libldap2-dev \
    libmemcached-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    nginx-full \
    puppet \
    python \
    python-dev \
    python-pip \
    python-six \
    python-virtualenv \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-six \
    rabbitmq-server \
    sudo \
    wget \
    zlib1g-dev \
 && locale-gen en_US.UTF-8

COPY ./install_zulip.sh /usr/bin/install_zulip.sh

RUN /usr/bin/install_zulip.sh \
 # Cleanup
 && apt-get clean \
 && apt-get purge -y \
    git \
    build-essential \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh

COPY createZulipRealm.sh /opt/createZulipRealm.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["app:run"]
