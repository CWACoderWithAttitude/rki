#!/bin/sh

output_folder=data
#output_folder=test
docker run -it \
  --rm=true \
  --name rki_fetcher \
  --mount type=bind,source="$(pwd)"/$output_folder,target=/app/data \
  rki_fetcher
