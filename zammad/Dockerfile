FROM debian:stretch
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

ENV ZAMMAD_VERSION 2.5.0
ENV RAILS_ENV production
ENV RUBY_VERSION 2.4.2
ENV TERM linux

RUN useradd -m zammad

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    bison \
    build-essential \
    curl \
    gawk \
    git \
    libffi-dev \
    libgdbm-dev \
    libgmp-dev \
    libmariadbclient-dev \
    libncurses5-dev \
    libreadline6-dev \
    libssl-dev \
    libsqlite3-dev \
    libtool \
    libxml2-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    libyaml-0-2 \
    mariadb-server \
    nginx \
    patch \
    # rvm requires ps
    procps \
    pkg-config \
    sqlite3 \
    supervisor \
    sudo \
    zlib1g-dev \
 && cd /home/zammad \
 && sudo -u zammad git clone -b $ZAMMAD_VERSION https://github.com/zammad/zammad.git \
 && sudo -u zammad gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
 && sudo -u zammad bash -c "curl -L https://get.rvm.io | bash -s stable" \
 && sudo -u zammad echo "export RAILS_ENV=${RAILS_ENV}" >> /home/zammad/.bash_profile \
 && sudo -u zammad bash -l -c "rvm install ${RUBY_VERSION}" \
 && sudo -u zammad bash -l -c "rvm use --default ${RUBY_VERSION}" \
 && sudo -u zammad bash -l -c "gem install bundler" \
 && cd zammad \
 # assets:precompile needs config/database.yml which looks more or less
 # realistic. Then, it will be replaced for the real one.
 && sed -e 's#.*adapter: postgresql#  adapter: nulldb#g' -e 's#.*username:.*#  username: postgres#g' -e 's#.*password:.*#  password: \n  host: zammad-postgresql\n#g' < config/database.yml.pkgr > config/database.yml \
 && sudo -u zammad bash -l -c "bundle install --without test development postgres" \
 && sudo -u zammad bash -l -c "bundle exec rake assets:precompile" \
 # Cleanup
 && apt-get purge -y \
    autoconf \
    automake \
    bison \
    curl \
    build-essential \
    git \
    patch \
 && apt-get autoremove -y

COPY ./config/database.yml /home/zammad/zammad/config/database.yml

COPY ./config/supervisord.conf /etc/supervisor/supervisord.conf

COPY ./config/zammad.conf /etc/nginx/sites-available/default

COPY ./run_webserver.sh /usr/bin/run_webserver.sh

COPY ./run_websocket_server.sh /usr/bin/run_websocket_server.sh

COPY ./run_scheduler.sh /usr/bin/run_scheduler.sh

COPY ./run_nginx.sh /usr/bin/run_nginx.sh

