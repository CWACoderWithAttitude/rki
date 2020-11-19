#!/bin/sh
docker run -it \
  --rm=true \
  --name covid_basher \
  --mount type=bind,source="$(pwd)"/csv,target=/app/csv \
  --mount type=bind,source="$(pwd)"/data,target=/app/data \
  covid_basher 
