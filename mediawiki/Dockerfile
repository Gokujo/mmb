FROM armv7/armhf-debian
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

COPY qemu-arm-static /usr/bin/qemu-arm-static

ENV MEDIAWIKI_VERSION REL1_27

RUN apt-get update && apt-get install -y \
    git \
    mysql-client \
    nginx \
    # Only for PHP 5.5 and up.
    php5-apcu \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-intl \
    php5-mysql \
    supervisor \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN cd /var/www \
 && git clone -b $MEDIAWIKI_VERSION --depth 1 https://github.com/wikimedia/mediawiki.git w \
 # Installing some external dependencies (e.g. via composer) is required.
 # See https://www.mediawiki.org/wiki/Download_from_Git#Fetch_external_libraries
 && cd /var/www/w \
 && git clone -b $MEDIAWIKI_VERSION --depth 1 https://github.com/wikimedia/mediawiki-vendor.git vendor \
 # The default skin must be installed explicitly
 && cd /var/www/w/skins \
 && git clone -b $MEDIAWIKI_VERSION --depth 1 https://github.com/wikimedia/mediawiki-skins-Vector.git vector \
 && cd /var/www/w/extensions \
 # Install VisualEditor from the original git repo because the GitHub mirror doesn't work.
 && git clone -b $MEDIAWIKI_VERSION --depth 1 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/VisualEditor.git VisualEditor \
 && cd VisualEditor \
 && git submodule update --init \
 && cd /var/www && chown -R www-data:www-data w \
 # Security & setup warnings:
 # php does not seem to be setup properly to query system environment variables.
 # The test with getenv("PATH") only returns an empty response.
 && sed -i -e "s/;env\[PATH\]/env\[PATH\]/" /etc/php5/fpm/pool.d/www.conf \
 # Do not clear environment in FPM workers.
 && sed -i -e "s/;clear_env = no/clear_env = no/" /etc/php5/fpm/pool.d/www.conf

COPY ./config/LocalSettings.php /var/www/w
COPY ./config/default /etc/nginx/sites-available/default
COPY ./config/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./run_nginx.sh /usr/bin/run_nginx.sh

