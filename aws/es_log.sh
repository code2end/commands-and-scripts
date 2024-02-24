AWS_CREDENTIALS_FILE="$HOME/.aws/credentials"
DEFAULT_AWS_PROFILE="default"

# Prompt the user to input the AWS profile
read -p "Enter the AWS profile (default: $DEFAULT_AWS_PROFILE): " AWS_PROFILE_INPUT

# Use the default profile if no input is provided
if [ -z "$AWS_PROFILE_INPUT" ]; then
  AWS_PROFILE="$DEFAULT_AWS_PROFILE"
else
  AWS_PROFILE="$AWS_PROFILE_INPUT"
fi

# Extract AWS credentials from the file for the specified profile
if [ -f "$AWS_CREDENTIALS_FILE" ]; then
  AWS_ACCESS_KEY_ID=$(awk -F "=" -v profile="$AWS_PROFILE" '$1 == "[" profile "]" {p=1} p && /aws_access_key_id/ {print $2; exit}' "$AWS_CREDENTIALS_FILE" | tr -d '[:space:]')
  AWS_SECRET_ACCESS_KEY=$(awk -F "=" -v profile="$AWS_PROFILE" '$1 == "[" profile "]" {p=1} p && /aws_secret_access_key/ {print $2; exit}' "$AWS_CREDENTIALS_FILE" | tr -d '[:space:]')
  AWS_SESSION_TOKEN=$(awk -F "=" -v profile="$AWS_PROFILE" '$1 == "[" profile "]" {p=1} p && /aws_session_token/ {print $2; exit}' "$AWS_CREDENTIALS_FILE" | tr -d '[:space:]')
else
  echo "AWS credentials file not found: $AWS_CREDENTIALS_FILE"
  exit 1
fi

OPENSEARCH_URL="<opensearch-url>"

docker run -d --platform linux/amd64 \
  -v /tmp/dummy:/root/.aws/credentials \
  -e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
  -e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
  -e AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN" \
  -p 9500:9200 \
  --name aws-os-dashboards-dev \
  santthosh/aws-es-kibana \
  -b 0.0.0.0 "$OPENSEARCH_URL"

  echo "Script executed"