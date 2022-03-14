# External Scheduler Script for IBP via AI
#  Only to submit the job. verification done via AI

#set -x

# This is needed for libcurl
LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH


# Job Variables
job_text="{{IBP_TEMPLATE_TEXT}}"
job_text_4url=$(urlencode "${job_text} via Control-M")
#job_text_4url="{ {job_template_name} } via Control-M"
#job_text_4url="viaControl-M"
job_template_name="{{IBP_TEMPLATE_NAME}}"
job_user={{job_user}}

echo "Template: -->{{IBP_TEMPLATE_NAME}}<--"

# Validations

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
	# log file
	if [ ! -d "~/custom/log" ]; then 
		mkdir -p ~/custom/log
	fi
	cd ~/custom/log
	local_dir=`pwd`
	now=$(date +"%F_%H_%M_%S")
	log_filename="$local_dir/$job_template_name-$now.txt"
	echo "Log file is : " $log_filename | tee -a $log_filename

	echo Job Template Text is $job_text  | tee -a $log_filename
	echo Job Template Name is $job_template_name  | tee -a $log_filename

	# Username and password are that of a user with privileges to access IBP system api
	#username="<IBP communication username>"
	username="{{RESTUserName}}"

	#Encode password for for Basic Authorization
	enc="$(echo -n "$username:{{RESTPassword}}" | base64)"
	encauth="Authorization: Basic $enc"

	# base service URL
	#site_url="complete base URL"
	site_url="https://${hostname}{{RESTPort}}{{RESTServiceURL}}"
	echo Site URL is $site_url | tee -a $log_filename

	# data parameters passed to our target service (Job Scheduling)
	data="/?JobTemplateName='$job_template_name'&JobText='$job_text_4url'&JobUser='$job_user'"
	# target service (in this case the scheduling service)
	es_url="$site_url/JobSchedule$data"
	echo "Scheduling Job URL will be: " $es_url | tee -a $log_filename

	cookie='{{IBP_COOKIE}}'
	echo Cookie is $cookie  | tee -a $log_filename

	token={{IBP_CSRF_TOKEN}}
	echo Retrieved Token $token  | tee -a $log_filename

	# Schedule Job
	# next line to be used with debug (-v for curl)
	#post_response=$(curl -v -i -k -s -H "Cookie: {{IBP_COOKIE}}" -H 'cache-control: no-cache' -X POST --url "$es_url" -H "$encauth" -H "x-csrf-token: $token" )
	post_response=$(curl -i -k -s -H "Cookie: {{IBP_COOKIE}}" -H 'cache-control: no-cache' -X POST --url "$es_url" -H "$encauth" -H "x-csrf-token: $token" )

	rc=$?

	echo $post_response | tee -a $log_filename

	# Parse response for name and run-count (used in retrieving status)
	job_name=$(echo $post_response | sed "s/.*<d:JobName>//g" | sed "s/<\/d:JobName>.*//g")
	echo Retrieved job_name $job_name | tee -a $log_filename

	job_run_count=$(echo $post_response | sed "s/.*<d:JobRunCount>//g" | sed "s/<\/d:JobRunCount>.*//g")
	echo Retrieved job_run_count $job_run_count | tee -a $log_filename

	#check for errors when triggering job in IBP

	if echo "$job_name" | grep -q "error" || echo "$job_name" | grep -q "unavailable" || echo "$job_name" | grep -q "no valid server";
	then
		echo "Error when triggering Job:" $job_text " (" $job_template_name ")" | tee -a $log_filename
		echo "HTML response from IBP: " | tee -a $log_filename
		echo $job_name | tee -a $log_filename
		rc=1
	fi

	if [ -z "$job_name" ];
	then
		echo "Error when triggering Job:" $job_text " (" $job_template_name " )" | tee -a $log_filename
		echo "Possible network or IBP server URL issue. Check that IBP Job Management URL can be reached:" | tee -a $log_filename
		rc=1
	fi
fi

exit $return_code