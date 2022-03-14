# External Scheduler Script for IBP via AI
#  last IBP reporting step (post-execution)

#set -x

return_code=0

#hostname="Hostname without including https"
hostname="{{RESTHost}}"
if [[ ! $hostname =~ ^my[0-9]{6}-api.scmibp[0-9]+.ondemand.com ]]; then
	# The connection profile has a non-conforming host name.
    echo "----------------------------------------------------------------------------"
    echo "Control-M Job terminated: Improper host in Connection profile (rc=10)"
    echo "----------------------------------------------------------------------------"
    echo "Hostname                      | {{RESTHost}}"
	echo "    Examples: my123456-api.scmibp.ondemand.com"
	echo "              my123456-api.scmibp1.ondemand.com"
    echo "----------------------------------------------------------------------------"
    return_code=10
elif [ "{{IBP_TEMPLATE_NAME}}" == "" ]; then
	# After the first rest call, the template name was not found
    echo "----------------------------------------------------------------------------"
    echo "Control-M Job terminated: The template name was not found (rc=11)"
    echo "----------------------------------------------------------------------------"
    echo "IBP Template Choice           | {{job_choice}}"
    echo "IBP Template                  | {{job_template}}"
    echo "----------------------------------------------------------------------------"
    return_code=11
else
    # If something ran, there is an extended status json available.
    # log file
    if [ ! -d "~/custom/log" ]; then 
        mkdir -p ~/custom/log
    fi
    cd ~/custom/log
    local_dir=`pwd`
    now=$(date +"%F_%H_%M_%S")
    response="$local_dir/end-response-$now.txt"
    status='{{IBP_JOB_STATUS_INFO}}'

    #Beautify json
    echo $status | grep -Eo '"[^"]*" *(: *([0-9]*|"[^"]*")[^{}\["]*|,)?|[^"\]\[\}\{]*|\{|\},?|\[|\],?|[0-9 ]*,?' | awk '{if ($0 ~ /^[}\]]/ ) offset-=4; printf "%*c%s\n", offset, " ", $0; if ($0 ~ /^[{\[]/) offset+=4}' > $response

    final_status=`cat $response | grep JobStatus | awk -F ":" '{print $2}' | awk -F \" '{print $2}' | sort -u`

    #Convert OData dates (epoch-ms) to human readable
    sed -i -e "s/\\/Date(//g" -e 's/"\\/"/g' -e 's/)\\\/"/"/g' $response
    cp $response $response.tmp
    awk -F ":" '{
		if ($1 ~ /DateTime/) {
			if ($2 ~ /,$/) {
				$2 = strftime("%F %T %Z", substr($2,2,10))
				print $1 ":\"" $2 "\","
			} else {
				$2 = strftime("%F %T %Z", substr($2,2,10))
				print $1 ":\"" $2 "\""
			}
		} else {
			print $0
		}
	}' $response.tmp > $response

	rm $response.tmp

	if [ "${final_status}" == "F" ]; then
		message="IBP Execution Completed (rc=0)"
	elif [ "${final_status}" == "R" ]; then
		message="Execution on IBP still continues (rc=12)"
		return_code=12
	elif [ "${final_status}" == "A" ]; then
		message="IBP Execution Cancelled (rc=13)."
		return_code=13
	else
		message="Unknown Status Code Returned. (rc=14)"
		return_code=14
	fi

	echo "----------------------------------------------------------------------"
	echo " ${message}"
	echo "----------------------------------------------------------------------"
	echo "IBP Template Name             | {{IBP_TEMPLATE_NAME}}"
	echo "IBP Template Text             | {{IBP_TEMPLATE_TEXT}}"
	echo "IBP Job Name                  | {{IBP_JOB_NAME}}"
	echo "IBP Job Run Count             | {{IBP_JOB_RUN_COUNT}}"
	echo "IBP Job Status                | ${final_status}"
	echo "----------------------------------------------------------------------"
	echo "Extended information in json below."
	cat $response
fi

exit $return_code