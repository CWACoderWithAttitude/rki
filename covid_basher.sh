#!/bin/sh

export_path=csv
mkdir -p $export_path

#
# We deal with data on german districts here
#   Currently data on "Wetteraukreis" is processed.
#   You may change or omit the "select" statement to fit you needs
#
echo "LastUpdate;name;count;weekIncidence;casesPer100k"
for file in $(ls data/2020-*dis*.json); do
  cat $file | jq -rc '(.lastUpdate|tostring) + ";" + (.districts | .[] | select( .name=="Wetteraukreis")| .name + ";" + (.count|tostring) + ";" + (.weekIncidence|tostring) +  ";" + (.casesPer100k|tostring))' 
done

#
# we deal with data on german federal states here
#   Please mind the "select" in the second "jq" invocaton.
#   You may change or omit the "select" statement to fit you needs
#
filename_gesamt="$export_path/export_gesamt.csv"
echo "LastUpdate;name;count;weekIncidence;casesPer100k" > $filename
echo "LastUpdate;name;count;weekIncidence;casesPer100k" > $filename_gesamt
for file in $(ls data/2020-*api*.json); do
  # district data contains unix timestamps
  #   lets convert those to something human readable
  ts1=$(cat $file | jq -rc '.lastUpdate')
  ts2=${ts1%???}
  ts3=$(gdate -d@$ts2 +%F)
  filename="$export_path/export_api_$ts3.csv"

  # convert daily repo
  cat $file | jq -rc '.states | .[] | .name + ";" + (.count|tostring) + ";" + (.weekIncidence|tostring) +  ";" + (.casesPer100k|tostring)' >> $filename 

  # data for 
  cat $file | jq --arg t $ts3 -rc '.states | .[] | select( .name == "Hessen") | $t + ";" +  .name + ";" + (.count|tostring) + ";" + (.weekIncidence|tostring |(split(".")|join(",")) ) +  ";" + (.casesPer100k|tostring | (split(".")|join(",")))' >> $filename_gesamt 
done

# EOF