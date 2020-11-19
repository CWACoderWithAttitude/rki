# rki

Convert RKI data on covid-19 from json to csv.
There're two main purposes:
- Data on german `Bundesländer` (states) is converted from json to csv.
- Data on districts `Landkreise` is converted from json to csv. 
  Decimal points are changed to local version and unix timestamps are rewritten to a more user friendly format.
## Requirements

- Requires [local docker](https://docs.docker.com/engine/install/) installation.
- 
## How to use

I've a script fetching rki-data every mornig. This data is located in `data`.
The script `covid_basher.sh` converts those files from JSON ro csv:
```bash
$> ./buildConverterImage.sh
$> ./runConverterImage.sh
```
