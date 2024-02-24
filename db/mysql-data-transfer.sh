#!/bin/bash

# Production Database Connection Details
prod_host=""
prod_user=""
prod_password=""
prod_database=""

# Local Database Connection Details
local_host=""
local_user=""
local_password=""
local_database=""

# Export production data
mysqldump --set-gtid-purged=OFF --host="$prod_host" --user="$prod_user" --password="$prod_password" "$prod_database" > prod_data.sql

# Import production data into local database
mysql --host="$local_host" --user="$local_user" --password="$local_password" "$local_database" < prod_data.sql

# Cleanup - Remove the exported SQL file
rm prod_data.sql

echo "Production data exported and imported into local database successfully."
