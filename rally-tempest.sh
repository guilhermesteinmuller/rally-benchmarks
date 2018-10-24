#!/bin/bash

SCENARIOS=( compute network image identity volume )
report_file_name="rally-$(date +"%d-%b-%y")"

for i in "${SCENARIOS[@]}" 
do
    echo "rally verify start --id $1  --pattern set=$i"
done


