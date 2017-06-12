#!/bin/sh
sed -i -e "s/MEDIAWIKI_PROTOCOL/${MEDIAWIKI_PROTOCOL}/" /srv/parsoid/config.yaml
sed -i -e "s/MEDIAWIKI_HOST/${MEDIAWIKI_HOST}/" /srv/parsoid/config.yaml
sed -i -e "s/PORT/${PORT}/" /srv/parsoid/config.yaml

cd /srv/parsoid && npm start

