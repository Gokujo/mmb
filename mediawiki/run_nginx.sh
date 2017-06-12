#!/bin/sh

sed -i -e "s/WG_SITENAME/${WG_SITENAME}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_META_NAMESPACE/${WG_META_NAMESPACE}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_PROTOCOL/${WG_PROTOCOL}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_SERVER/${WG_SERVER}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_EMERGENCY_CONTACT/${WG_EMERGENCY_CONTACT}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_PASSWORD_SENDER/${WG_PASSWORD_SENDER}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_DB_SERVER/${WG_DB_SERVER}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_DB_NAME/${WG_DB_NAME}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_DB_USER/${WG_DB_USER}/" /var/www/w/LocalSettings.php
sed -i -e "s/WG_DB_PASSWORD/${WG_DB_PASSWORD}/" /var/www/w/LocalSettings.php
sed -i -e "s/ALLOW_ACCOUNT_CREATION/${ALLOW_ACCOUNT_CREATION}/" /var/www/w/LocalSettings.php
sed -i -e "s/ALLOW_ACCOUNT_EDITING/${ALLOW_ACCOUNT_EDITING}/" /var/www/w/LocalSettings.php
sed -i -e "s/ALLOW_ANONYMOUS_READING/${ALLOW_ANONYMOUS_READING}/" /var/www/w/LocalSettings.php
sed -i -e "s/ALLOW_ANONYMOUS_EDITING/${ALLOW_ANONYMOUS_EDITING}/" /var/www/w/LocalSettings.php

cd /var/www/w
php maintenance/update.php

sed -i -e "s/PORT/${PORT}/" /etc/nginx/sites-available/default

nginx -g 'daemon off;'

