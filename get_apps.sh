#!/bin/sh

set -e

mkdir -p /tmp/alfred

# Fetch data if not fetched. This gets deleted once per day by a cron cause its easy.
if [ ! -f "/tmp/alfred/mshelley.json" ];
then
  # Fetch my data
  beyond-curl https://registry.sqprod.co/api/v1/user/mshelley.json > /tmp/alfred/mshelley.json
fi

# Make it so alfred can find python installed using pyenv
eval "$(pyenv init --path)"

# Hackily parse it to get my apps
python /Users/mshelley/Development/alfred/get_apps.py /tmp/alfred/mshelley.json
