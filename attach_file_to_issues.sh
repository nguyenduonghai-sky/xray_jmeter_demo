#!/bin/bash
 
BASEURL=${JIRA_BASEURL:-http://yourjiraserver.example.com}
USERNAME=${JIRA_USERNAME:-admin}
PASSWORD=${JIRA_PASSWORD:-admin}
 
ISSUEKEY=$1
 
for file in "${@:2}"
do
 curl -D- -u $USERNAME:$PASSWORD -X POST -H "X-Atlassian-Token: nocheck" -F "file=@$file" $BASEURL/rest/api/2/issue/$ISSUEKEY/attachments
done