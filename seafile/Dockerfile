FROM debian:stretch
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

ENV LIBEVHTP 1.1.6

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    intltool \
    libarchive-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libfuse-dev \
    libglib2.0-dev \
    libmariadbclient-dev \
    libsqlite3-dev \
    libtool \
    libjansson-dev \
    python-pip \
    uuid-dev \
    valac \
    wget \
    less \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && pip install \
    django==1.8.* \
    django-statici18n \
 && cd && wget https://github.com/ellzey/libevhtp/archive/$LIBEVHTP.tar.gz \
 && tar xzvf $LIBEVHTP.tar.gz \
 && cd libevhtp-$LIBEVHTP \
 && cmake -DEVHTP_DISABLE_SSL=ON -DEVHTP_BUILD_SHARED=OFF . && make && make install \
 && apt-get autoremove -y


