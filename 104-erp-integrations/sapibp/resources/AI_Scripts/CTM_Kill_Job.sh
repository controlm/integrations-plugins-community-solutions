#! bash -x
# External Scheduler Script for IBP via AI
# THIS IS A JOBCANCEL script
#set -x

# This is needed for libcurl
LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

# Job Variables
job_text="{{IBP_TEMPLATE_TEXT}}"
#job_text_4url=$(urlencode "{ {job_template_name} } via Control-M")
#job_text_4url="{ {job_template_name} } via Control-M"
job_text_4url="viaControl-M"
job_template_name="{{IBP_TEMPLATE_NAME}}"
job_user={{job_user}}

# log file
if [ ! -d "~/custom/log" ]; then 
	mkdir -p ~/custom/log
fi
cd ~/custom/log
local_dir=`pwd`
now=$(date +"%F_%H_%M_%S")
log_filename="$local_dir/$job_template_name-$now.txt"
echo "Log file is : " $log_filename > $log_filename
cancel_rsp="$local_dir/$job_template_name-cance-$now.txt"
echo "Cancel Response file is : " $cancel_rsp >> $log_filename

echo Job Template Text is $job_text  >> $log_filename
echo Job Template Name is $job_template_name  >> $log_filename

# Username and password are that of a user with privileges to access IBP system api
#username="<IBP communication username>"
username="{{RESTUserName}}"

#Encode password for for Basic Authorization
enc="$(echo -n "$username:{{RESTPassword}}" | base64)"
encauth="Authorization: Basic $enc"

# base service URL
#hostname="Hostname without including https"
hostname={{RESTHost}}
#site_url="complete base URL"
site_url="https://${hostname}{{RESTPort}}{{RESTServiceURL}}"
echo Site URL is $site_url >> $log_filename

# data parameters passed to our target service (Job Cancel)
data="?JobName='{{IBP_JOB_NAME}}'&JobRunCount='{{IBP_JOB_RUN_COUNT}}'"
# target service (in this case the scheduling service)
es_url="${site_url}/JobCancel${data}"
echo "Cancel Job URL will be: " $es_url >> $log_filename

cookie='{{IBP_COOKIE}}'
#echo Cookie is $cookie  >>$log_filename

token={{IBP_CSRF_TOKEN}}
#echo Retrieved Token $token  >> $log_filename

# Cancel Job
# next line to be used with debug (-v for curl)
post_response=$(curl -k -s -H "Cookie: {{IBP_COOKIE}}" -H 'cache-control: no-cache' -X POST --url "$es_url" -H "$encauth" -H "x-csrf-token: $token" -H "Accept: application/json")
echo "$post_response" > $cancel_rsp.tmp
cat $cancel_rsp.tmp | grep -Eo '"[^"]*" *(: *([0-9]*|"[^"]*")[^{}\["]*|,)?|[^"\]\[\}\{]*|\{|\},?|\[|\],?|[0-9 ]*,?' | awk '{if ($0 ~ /^[}\]]/ ) offset-=4; printf "%*c%s\n", offset, " ", $0; if ($0 ~ /^[{\[]/) offset+=4}' >> $log_filename
rm $cancel_rsp.tmp

# data parameters passed to our target service (Job Get Info) same as JobCancel
# target service (in this case the scheduling service)
es_url="${site_url}/JobinfoGet${data}"
echo "GetInfo Job URL will be: " $es_url >> $log_filename
post_response=$(curl -k -s -H "Cookie: {{IBP_COOKIE}}" -H 'cache-control: no-cache' -X GET --url "$es_url" -H "$encauth" -H "x-csrf-token: $token" -H "Accept: application/json")

echo $post_response >> $log_filename

echo $post_response > ${cancel_rsp}.tmp
#Beautify json
cat ${cancel_rsp}.tmp | grep -Eo '"[^"]*" *(: *([0-9]*|"[^"]*")[^{}\["]*|,)?|[^"\]\[\}\{]*|\{|\},?|\[|\],?|[0-9 ]*,?' | awk '{if ($0 ~ /^[}\]]/ ) offset-=4; printf "%*c%s\n", offset, " ", $0; if ($0 ~ /^[{\[]/) offset+=4}' > $cancel_rsp

#Convert OData dates (epoch-ms) to human readable
sed -i -e "s/\\/Date(//g" -e 's/"\\/"/g' -e 's/)\\\/"/"/g' $cancel_rsp
cp $cancel_rsp $cancel_rsp.tmp
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
}' $cancel_rsp.tmp > $cancel_rsp

rm $cancel_rsp.tmp 

final_status=`cat $cancel_rsp | grep JobStatus | awk -F ":" '{print $2}' | awk -F \" '{print $2}' | sort -u`

echo "------------------------------------------------------------------------" | tee -a $log_filename
echo " Killed execution. Verify IBP for remaining running components. (rc=15)"  | tee -a $log_filename
echo "------------------------------------------------------------------------" | tee -a $log_filename
echo "IBP Template Name             | {{IBP_TEMPLATE_NAME}}" | tee -a $log_filename 
echo "IBP Template Text             | {{IBP_TEMPLATE_TEXT}}" | tee -a $log_filename
echo "IBP Job Name                  | {{IBP_JOB_NAME}}" | tee -a $log_filename
echo "IBP Job Run Count             | {{IBP_JOB_RUN_COUNT}}" | tee -a $log_filename
echo "IBP Job Status                | ${final_status}" | tee -a $log_filename
echo "------------------------------------------------------------------------" | tee -a $log_filename

echo "Extended information in json below." | tee -a $log_filename
cat $cancel_rsp | tee -a $log_filename

exit 15