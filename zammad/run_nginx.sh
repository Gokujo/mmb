#!/bin/sh

sed -i -e "s/RAILS_SERVER_PORT/${RAILS_SERVER_PORT}/" /etc/nginx/sites-available/default
sed -i -e "s/WS_PORT/${WS_PORT}/" /etc/nginx/sites-available/default
sed -i -e "s/PORT/${PORT}/" /etc/nginx/sites-available/default

nginx -g 'daemon off;'

