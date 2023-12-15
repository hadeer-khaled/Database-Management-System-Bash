#!/usr/bin/bash

read -p "Enter the Table Name you want to update it: " tableName

read -p "Enter the Column Name you want to update it: " desiredColumnName  
read -p "Enter the New $desiredColumnName value: " newValue 

read -p "Enter the Condition Column: " whereColumnName  
read -p "Enter the Condition Value: " whereValue 


metaDataFile=$tableName.metadata
dataFile=$tableName.data
header=`head -n 1 $metaDataFile`

#field_number=$(echo "$header" | awk -F: 'BEGIN{field_name=$field_name } {for(i=1; i<=NF; i++) if($i == field_name) print i}')
desiredColumnNumber=$(echo "$header" | awk -F: -v desiredColumnName="$desiredColumnName" '{for(i=1; i<=NF; i++) if($i == desiredColumnName) print i}')
CondColumnNumber=$(echo "$header" | awk -F: -v whereColumnName="$whereColumnName" '{for(i=1; i<=NF; i++) if($i == whereColumnName) print i}')

temp_file=$(mktemp)
if grep -q "$whereValue" "$dataFile"; then
    awk  -v whereValue="$whereValue" \
        -v new_name="$newValue" \
        -v whereColumnName="$whereColumnName" \
        -v CondColumnNumber=$CondColumnNumber\
        -v desiredColumnNumber=$desiredColumnNumber\
        'BEGIN { FS = OFS =":" } $CondColumnNumber == whereValue { $desiredColumnNumber = new_name } 1' "$dataFile" > "$temp_file"

    mv "$temp_file" "$dataFile"

    echo "Record with $whereColumnName=$whereValue updated successfully."
else
    echo "Record with $whereColumnName=$whereValue not found."
fi

# Clean up temporary file
rm -f "$temp_file"


: '------------------------------------------------------------------------------------

if [[ -n "$ColumnNameNumber" && -n "$whereColumnNameNumber" ]]; then
    echo "Field number of $ColumnNameNumber is: $ColumnNameNumber"
    echo "Field number of $whereColumnNameNumber is: $whereColumnNameNumber"
else
    echo "Field $field_name not found in the header."
fi
----------------------------------------------------------------------------------------'

