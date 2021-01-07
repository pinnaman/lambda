#!/bin/bash

# Thanks to MattJ at:
# http://www.brassmill.net/2015/10/using-the-aws-cli-with-roles-security-token-service-and-mfa/
#
# User must have 'iam:GetUser' permission on themselves that doesn't require MFA

[ -z $1 ] && echo "Please enter your MFA code" && exit 1

user=$(aws iam get-user \
                --query 'User.Arn' \
                --output text \
        ) || exit 1

profile=$(echo $user | cut -f2 -d '/')
serial=$(echo $user | sed 's/:user/:mfa/')

echo "$profile:$serial"

output=$(aws sts get-session-token \
                --query 'Credentials.[SecretAccessKey,AccessKeyId,SessionToken]' \
                --output text \
                --serial-number $serial \
                --token-code $1 \
        ) || exit 1

echo "$output"

aws_secret_access_key=$(echo $output | cut -f1 -d ' ')
aws_access_key_id=$(echo $output | cut -f2 -d ' ')
aws_session_token=$(echo $output | cut -f3 -d ' ')

aws configure set profile.$profile.aws_access_key_id $aws_access_key_id
aws configure set profile.$profile.aws_secret_access_key $aws_secret_access_key
aws configure set profile.$profile.aws_session_token $aws_session_token