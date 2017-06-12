#!/bin/sh

DELETED=/srv/mediawiki/deleted
IMAGES=/srv/mediawiki/images

if [ ! -d $DELETED ]; then
    mkdir -p $DELETED
    chown www-data:www-data $DELETED
else
    echo "${DELETED} already exists" >&2
fi

if [ ! -d $IMAGES ]; then
    mkdir -p $IMAGES
    chown www-data:www-data $IMAGES
else
    echo "${IMAGES} already exists" >&2
fi

