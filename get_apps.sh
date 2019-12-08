#!/bin/sh

set -e

# Fetch data if not fetched. This gets deleted once per day by a cron cause its easy.
if [ ! -f "/tmp/alfred/mshelley.json" ];
then
  # Fetch my data
  beyond-curl https://registry.sqprod.co/api/v1/user/mshelley.json > /tmp/mshelley.json
fi

# Hackily parse it to get my apps
python /Users/mshelley/Development/alfred/get_apps.py /tmp/mshelley.json
