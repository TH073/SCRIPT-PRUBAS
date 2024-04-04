#!/bin/bash

#create_release.sh $GITHUB_TOKEN $REPO_NAME $USER

REPO_OWNER="NBN23dev"
REPO_NAME=$2
GITHUB_TOKEN=$1
USER=$3

json=$(curl -u $USER:$GITHUB_TOKEN -X GET https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/refs/heads/main)
echo $json

message=$(echo $json | jq '.message')
echo $message
if [[ "$message"=="Not Found" ]]; then 
    echo "entro!"
    json=$(curl -u $USER:$GITHUB_TOKEN -X GET https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/refs/heads/master)
fi

sha=$(echo $json | jq '.object.sha')
echo $sha
curl -u $USER:$GITHUB_TOKEN -X POST -d "{\"ref\": \"refs/heads/release\", \"sha\": $sha}" https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/refs
