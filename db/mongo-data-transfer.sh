#!/bin/bash

# Database Information
database="<database>"
username="<username>"
password="<password>"
cluster="<cluster>"
collections=("<collection-name>")

# MongoDB URI
uri="mongodb+srv://$username:$password@$cluster/$database"

# Create temporary directory
mkdir -p tmp

for collection in "${collections[@]}"; do
    echo "Exporting $database/$collection ..."
    mongoexport --uri "$uri" --collection "$collection" --out "tmp/$collection.json"
done

local_host=127.0.0.1:27017

for FILE in "${collections[@]}"; do
    # Append "tmp" to the file path
    FILE="tmp/${FILE}"
    
    # Get the collection name without the extension
    c=$(basename "$FILE" .json)
    
    # Import the JSON file into MongoDB
    mongoimport --db="$database" --collection="$c" --drop --file="$FILE" --host "$local_host"
done

rm -r tmp

echo "MongoDB data exported successfully."
