#!/bin/sh

set -e

sed -i -e "s/DB_HOST/${DB_HOST}/" /home/zammad/zammad/config/database.yml
sed -i -e "s/DB_PORT/${DB_PORT}/" /home/zammad/zammad/config/database.yml
sed -i -e "s/DB_NAME/${DB_NAME}/" /home/zammad/zammad/config/database.yml
sed -i -e "s/DB_USERNAME/${DB_USERNAME}/" /home/zammad/zammad/config/database.yml
sed -i -e "s/DB_PASSWORD/${DB_PASSWORD}/" /home/zammad/zammad/config/database.yml

cd /home/zammad/zammad

sudo -u zammad bash -c -l "rake db:create" &
sudo -u zammad bash -c -l "rake db:migrate" &
sudo -u zammad bash -c -l "rake db:seed" &
sudo -u zammad bash -c -l "rails s -p ${RAILS_SERVER_PORT}"

