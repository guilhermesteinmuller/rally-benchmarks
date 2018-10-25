#!/bin/bash

SCENARIOS=( compute network image identity volume )
report_file_name="rally-$(date +"%d-%b-%y")-tempest"
tempest_version="rally verify list-verifiers | grep $1 | awk '{ print $16 }' | sed -e 's/\Status\>//g' | sed '/^$/d'"

for i in "${SCENARIOS[@]}" 
do
    rally verify start --id $1  --pattern set=$i
    verify_id=rally verify list | awk '{print $2}' | sed -e 's/\UUID\>//g' | sed '/^$/d'
    rally verify report --uuid $(verify_id) --type html --to "$({report_file_name}_${tempest_version}_${i}).html"
    rally veriry delete --uuid $(verify_id) 
done


