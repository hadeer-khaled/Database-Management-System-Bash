#!/bin/bash
checkSpace(){
local name="$1" 
	if [[ $name =~ [[:space:]] ]]
	then 
		echo ">>>>>>>>> Warning: Database name cannot contain spaces, the spaces will be replaced with uderscore(_)"
		echo ">>>>>>>>> The database name will be \"${name// /_}\" instead of \"$name\" "
		name=${name// /_}
	fi
	echo $name
}

read -p "Enter the Table Name you want to update it: " tableName

read -p "Enter the Column Name you want to update it: " desiredColumnName  
read -p "Enter the New $desiredColumnName value: " newValue 

read -p "Enter the Condition Column: " whereColumnName  
read -p "Enter the Condition Value: " whereValue 


metaDataFile=$tableName.metadata
dataFile=$tableName.data
header=`head -n 1 $metaDataFile`

desiredColumnNumber=$(echo "$header" | awk -F: -v desiredColumnName="$desiredColumnName" '{for(i=1; i<=NF; i++) if($i == desiredColumnName) print i}')
CondColumnNumber=$(echo "$header" | awk -F: -v whereColumnName="$whereColumnName" '{for(i=1; i<=NF; i++) if($i == whereColumnName) print i}')

IFS=: read -a PKsArray < <(sed -n '3p' "$metaDataFile") 


if [ ${PKsArray[$(($desiredColumnNumber-1))]} ==  "yes" ]
then
       while IFS= read line; 
       echo $line
       do
	   if [ $newValue == $line ];
	   then
	   	echo "This value already exists";
	   	break;
	fi	   
	done < <(cut -d: -f$desiredColumnNumber "$dataFile")
else 
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

fi



checkName(){
local name="$1"
	if [ ${#name} -le 1 -o ${#name} -ge 64 ]
	then 
		echo ">>>>>>>>> Error: length should be from 1 to 64 characters."
		flag=0
	fi    	

	if ! [[ $DB_Name =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]
	then 
		echo ">>>>>>>>> Error: name can contain letters, uderscore and numbers only. But not start with number or uderscore"
		flag=0 
	fi
	echo flag
	}




