#!/usr/bin/bash

#____________________________________________________________________________________________________________________
while true
do
	insertMenu=("Insert new Field" "Insert new row" "Exit")
	echo "=== H&N Insert Menu ==="
	echo "=============================================================="
	select answer in "${insertMenu[@]}"
    do
        case $answer in
#____________________________________________________________________________________________________________________
#menu for choosing insert new column
"Insert new Field")
    pkFlag=false
    echo "You selected: $answer"
    read -p "Please enter table name: " tableName

    if [ -f "${tableName}.metadata" ]
    then
        read -p "Please enter field name: " fieldName

        while [[ ! "$fieldName" =~ ^[a-zA-Z][a-zA-Z0-9_] || ${#fieldName} -gt 64 ]]
         do
            echo "Sorry... invalid field name. Try another name starting with a letter, number, or underscore."
            read -p "Please enter field name for the new field: " fieldName
        done

        read -p "Please enter data type (string or number): " dataType

        while [[ "$dataType" != "string" && "$dataType" != "number" ]]
         do
            echo "Invalid data type. Enter 'string' or 'number'."
            read -p "Please enter data type (string or number): " dataType
        done
	
        existingPKs=$(awk -F: 'NR=3 {print $'$((fieldNumber+1))'}' "${tableName}.metadata" | tr '\n' ' ')

        while [ "$pkFlag" != "true" ]
         do
            read -p "Is $fieldName a primary key? (yes/no): " isPrimary
            if [[ "$isPrimary" == "yes" ]]
            then
                if [[ $counter -eq 0 && ! $(grep -o -w "yes" <<< "$primaryKeys") && ! $(grep -o -w "$isPrimary" <<< "$existingPKs") ]]
                then
                    primaryKeys+="$isPrimary:"
                    counter=$((counter + 1))
                    pkFlag=true
                else
                    echo "Sorry... can't add more than one unique PK in the same table or duplicate primary key value"
                    pkFlag=false
                fi
            elif [[ "$isPrimary" == "no" ]]
            then
                primaryKeys+="$isPrimary:"
                pkFlag=true
            else 
                echo "Invalid input. Please enter 'yes' or 'no' for primary key."

            fi
        done

        oldMetadata="${tableName}.metadata"
        newMetaData="${tableName}.new.metadata"
        awk -F: -v fieldName="$fieldName" -v dataType="$dataType" -v isPrimary="$isPrimary" '{
            if (NR == 1) {
                print $0 fieldName":"
            } else if (NR == 2) {
                print $0 dataType":"
            } else {
                print $0 isPrimary":"
            }
        }' "$oldMetadata" >"$newMetaData"

        mv "$newMetaData" "$oldMetadata"
        echo "Field '$fieldName' added to table '$tableName'."
    else
        echo "Table '$tableName' does not exist"
    fi
    ;;


#____________________________________________________________________________________________________________________
#menu for choosing insert  new row (data)

"Insert new row")
    echo "You selected: $answer"
    read -p "Please enter table name to insert a new row: " tableName
    if [ -f "${tableName}.metadata" ]
    then
        fieldNames=($(awk -F: 'NR==1 {for (i=1; i<=NF; i++) print $i}' "${tableName}.metadata"))
        fieldDataTypes=($(awk -F: 'NR==2{for (i=1; i<=NF; i++) print $i}' "${tableName}.metadata"))
        fieldIsPrimary=($(awk -F: 'NR==3{for (i=1; i<=NF; i++) print $i}' "${tableName}.metadata"))
        for ((i=0; i<${#fieldNames[@]}; i++))
        do
            fieldName="${fieldNames[i]}"
            fieldDataType="${fieldDataTypes[i]}"
            fieldsPrimary="${fieldIsPrimary[i]}"
            existingValues=($(cut -d: -f$((i+1)) "${tableName}.data"))
            echo "${existingValues[@]}"
            var=0
            while [[  $var == 0 ]]; do
            var=1
                read -p "Enter value for $fieldName: " fieldValue
                 if [[ "$fieldDataType" == "number" &&  -z "$fieldValue" ]]
                 then
                		 if [  "$fieldsPrimary" == "yes"  ]
            		        then
            		        echo "Do not enter null in pk ! "
            		                       var=0
				else
				fieldValue=0
				fi
                 elif [[ "$fieldDataType" == "string" && -z "$fieldValue" ]]
                 then
                                 if [  "$fieldsPrimary" == "yes"  ]
            		        then
            		                    		        echo "Do not enter null in pkhllhh ! "
            		        var=0
				else
				fieldValue=null
				fi
                elif [[ "$fieldDataType" == "string" && ! "$fieldValue" =~ ^[A-Za-z]+$ ]]
                then
                    echo "Invalid input. '$fieldName' should be a string."
                    var=0
                elif [[ "$fieldDataType" == "number" && ! "$fieldValue" =~ ^[0-9]+$ ]]
                 then
                    echo "Invalid input. '$fieldName' should be a number."
                    var=0
                else
                    if [ "$fieldsPrimary" == "yes" ]
                    then
                        for val in "${existingValues[@]}"
                        do
                            if [ "$val" == "$fieldValue" ]
                            then
                                echo "Error: Value for primary key column '$fieldName' must be unique."
                                var=0
                              	break
                                else
                           	var=1
                            fi
                        done
                    #else 
                    
                    fi
                    
                    
                fi
   
            done
                echo -n "$fieldValue:" >> "${tableName}.data"
                    echo "Value '$fieldValue' added for column '$fieldName'."
        done
        echo >> "${tableName}.data"
    else
        echo "Table '$tableName' does not exist."
    fi
    ;;
#____________________________________________________________________________________________________________________
            "Exit")
                echo "Exiting program!"
                exit;;
            *)
                echo "Invalid choice. Please enter a valid option."
                ;;
        esac
        break
    done
done
