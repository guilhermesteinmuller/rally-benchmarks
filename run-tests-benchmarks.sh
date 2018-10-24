#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export http_proxy=http://10.5.0.130:3128 
cloud="cloud"
mail_to=""

tasks="/root/basic-with-existing-users.yaml"
mail_template="/root/rally-mail.template"
report_file_name="rally-$(date +"%d-%b-%y")-using-basic-with-existing-users.yaml"
report_dir="/var/www/html/reports/$report_file_name.html"
log="/var/log/rally-tasks/$report_file_name.log"

# Execute rally task
rally task start $tasks

# Save detailed log
rally task detailed >> $log

# Get task id
task_id=$(cat $log | grep -m 1 task | cut -d " " -f4)

# Generate rally report
rally task report $task_id --out $report_dir

# Get number of tests failed
total_fails=0
for fail in $(cat $log | grep error |  cut -d " " -f4); do
	let total_fails+=$fail
done

# Send mail
# sed "s/<report_file_name>/$report_file_name/" $mail_template | mail -s "[Rally] Daily report for $cloud: $total_fails tests failed" $mail_to
