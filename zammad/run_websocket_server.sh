#!/bin/sh

set -e

cd /home/zammad/zammad

sudo -u zammad bash -c -l "./script/websocket-server.rb start"

