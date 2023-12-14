#!/bin/bash

# Specify the file containing the data
tableName="table1.data"

# Specify the column and value to identify the record to update
whereColumnName="id"
whereValue="10"

# Specify the new values for the record
newValue="hadeer"

# Temporary file
temp_file=$(mktemp)

desiredColumnNumber=2
CondColumnNumber=1

# Check if the record exists and update it
if grep -q "$whereValue" "$tableName"; then
    awk  -v whereValue="$whereValue" \
        -v new_name="$newValue" \
        -v whereColumnName="$whereColumnName" \
        -v CondColumnNumber=$CondColumnNumber\
        -v desiredColumnNumber=$desiredColumnNumber\
        'BEGIN { FS = OFS =":" } $CondColumnNumber == whereValue { $desiredColumnNumber = new_name } 1' "$tableName" > "$temp_file"
        cat $tableName
        cat $temp_file
        
    mv "$temp_file" "$tableName"
            cat $tableName

    echo "Record with $whereColumnName=$whereValue updated successfully."
else
    echo "Record with $whereColumnName=$whereValue not found."
fi

# Clean up temporary file
rm -f "$temp_file"
