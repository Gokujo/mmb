#!/bin/sh

set -e

cd /home/zammad/zammad

# The -t option allows scheduler to be run in interactive mode.
sudo -u zammad bash -c -l "./script/scheduler.rb start -t"

