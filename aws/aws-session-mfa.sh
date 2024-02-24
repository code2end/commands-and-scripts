#!/bin/bash

# Get profile from ~/.aws/credentials for which you temporary credentials (can be dev/prod/staging)
read -p "Enter IAM username (end part of your user arn): " username

# Get profile from ~/.aws/credentials for which you temporary credentials (can be dev/prod/staging)
read -p "Enter your AWS profile: " aws_profile

# Get MFA token from user
read -p "Enter MFA token code: " mfa_token

# Set variables
aws_region="<region>"
aws_mfa_serial="arn:aws:iam::<account-id>:mfa/${username}"

# Get temporary session token, access key, and secret key
temp_creds=$(aws sts get-session-token \
  --profile $aws_profile \
  --region $aws_region \
  --serial-number $aws_mfa_serial \
  --token-code $mfa_token \
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