#!/bin/sh

now=$(date +%Y-%m-%d_%H-%M)
basedir=data
api=$basedir/$now"_api.json"
districts=$basedir/$now"_districts.json"

curl -s https://rki-covid-api.now.sh/api/ > $api

curl -s https://rki-covid-api.now.sh/api/districts > $districts
# EOF