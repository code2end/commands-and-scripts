#!/bin/bash

# Set variables for input and output file paths
WT_FILE_PATH="/path/to/wt/file"
JSON_FILE_PATH="/path/to/output/json/file.json"

# Dump the WiredTiger file into a binary archive file
mongodump --dbpath "$WT_FILE_PATH" --archive > dump.archive

# Restore the data from the archive file to a JSON file
mongorestore --archive=dump.archive --nsFrom='*' --nsTo="$JSON_FILE_PATH"

# Remove the dump file
rm dump.archive

echo "Conversion complete."