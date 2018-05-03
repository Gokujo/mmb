#!/bin/sh

set -e

cd

mkdir -p "${DATA_DIR}" /root/zulip

# Zulip doesn't support installation from git.
wget -q https://github.com/zulip/zulip/releases/download/${ZULIP_VERSION}/zulip-server-${ZULIP_VERSION}.tar.gz -O zulip-server.tar.gz

tar xzvf zulip-server.tar.gz -C /root/zulip --strip-components=1

rm -rf /tmp/zulip-server.tar.gz
cp -rf /root/custom_zulip/* /root/zulip
rm -rf /root/custom_zulip

# zulip::voyager is for an all-in-one system;
# zulip::dockervoyager is for Docker.
export PUPPET_CLASSES="zulip::dockervoyager"
export DEPLOYMENT_TYPE="dockervoyager"
export has_nginx="0"
export has_appserver="0"

# Do not start Nginx after finishing the Zulip installation.
rm /etc/init.d/nginx
ln -s /bin/true /etc/init.d/nginx

/root/zulip/scripts/setup/install --hostname="$(hostname)" --email="docker-zulip"

cp -a   /root/zulip/zproject/prod_settings_template.py /etc/zulip/settings.py
ln -nsf /etc/zulip/settings.py /root/zulip/zproject/prod_settings.py

deploy_path=$(/root/zulip/scripts/lib/zulip_tools.py make_deploy_path)

mv /root/zulip "${deploy_path}"

ln -nsf /home/zulip/deployments/next /root/zulip
ln -nsf "${deploy_path}"             /home/zulip/deployments/next
ln -nsf "${deploy_path}"             /home/zulip/deployments/current
ln -nsf /etc/zulip/settings.py       "${deploy_path}"/zproject/prod_settings.py

mkdir -p "${deploy_path}"/prod-static/serve

cp -rT "${deploy_path}"/prod-static/serve /home/zulip/prod-static

chown -R zulip:zulip /home/zulip /var/log/zulip /etc/zulip/settings.py

rm -rf /root/zulip/puppet/ /var/lib/apt/lists/* /tmp/* /var/tmp/*

