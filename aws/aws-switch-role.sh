#!/bin/bash

# Set variables
aws_profile="default"
session_name="default-session"
prod_role_arn="arn:aws:iam::<account-id>:role/<role>"

temp_creds=$(aws sts assume-role \
  --role-arn $prod_role_arn \
  --role-session-name $session_name \
  --output text \
  --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]')

access_key=$(echo $temp_creds | cut -d ' ' -f 1)
secret_key=$(echo $temp_creds | cut -d ' ' -f 2)
session_token=$(echo $temp_creds | cut -d ' ' -f 3)

# Set credentials for temporary session
aws configure set aws_access_key_id $access_key --profile $aws_profile-session
aws configure set aws_secret_access_key $secret_key --profile $aws_profile-session
aws configure set aws_session_token $session_token --profile $aws_profile-session

# Set credentials as default
aws configure set aws_access_key_id $access_key --profile default
aws configure set aws_secret_access_key $secret_key --profile default
aws configure set aws_session_token $session_token --profile default

# Display message
echo "Temporary session credentials set for AWS CLI."