FROM armv7/armhf-debian
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

COPY qemu-arm-static /usr/bin/qemu-arm-static

ENV NODE_VERSION 6.11.0
ENV NVM_VERSION v0.33.2
ENV PARSOID_VERSION v0.7.1
ENV NODE_PATH /bin/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $PATH:/bin/versions/node/v$NODE_VERSION/bin

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    git \
    wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 # Install Node.js using NVM
 && cd && wget -qO- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash \
 && . ~/.nvm/nvm.sh \
 && nvm install $NODE_VERSION \
 && nvm use default \
 # Install Parsoid
 && git clone https://github.com/wikimedia/parsoid.git /srv/parsoid \
 && cd /srv/parsoid \
 && git checkout $PARSOID_VERSION \
 && npm install \
 # Clean up
 && apt-get purge --auto-remove -y \
    git \
    wget

COPY ./run_parsoid.sh /usr/bin/run_parsoid.sh
COPY ./config/config.yaml /srv/parsoid/config.yaml

ENTRYPOINT ["run_parsoid.sh"]

