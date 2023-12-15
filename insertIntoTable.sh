#!/usr/bin/bash

insertMenu=("Insert new Field" "Insert new row" "Exit")

while true
do
    echo "=== Insert Menu ==="
    select answer in "${insertMenu[@]}"
    do
        case $answer in
            "Insert new Field")
                echo "You selected: $answer"
                read -p "Please enter table name : " tableName
                if [ -f "${tableName}.metadata" ]
                 then
                    read -p "Please enter field name : " fieldName
                    while [[ ! "$fieldName" =~ ^[a-zA-Z][a-zA-Z0-9_] || ${#fieldName} -gt 64 ]]
                     do
                        echo "Sorry... invalid field name. Try another name starting with a letter, number, or underscore."
                        read -p "Please enter field name for the new field: " fieldName
                    done
                    
                    read -p "Please enter data type (string or number): " dataType
                    while [[ "$dataType" != "string" && "$dataType" != "number" ]]
                     do
                        echo "Invalid data type.enter 'string' or 'number'."
                        read -p "Please enter data type (string or number): " dataType
                    done

                    read -p "Is the new field a primary key? (yes or no): " isPrimary
                    while [[ "$isPrimary" != "yes" && "$isPrimary" != "no" ]]
                    do
                        echo "Invalid input. Please enter 'yes' or 'no' for primary key."
                        read -p "Is the new field a primary key? (yes or no): " isPrimary
                    done
			oldMetadata="${tableName}.metadata" 
			newMetaData="${tableName}.new.metadata"
                    awk -F: -v fieldName="$fieldName" -v dataType="$dataType" -v isPrimary="$isPrimary" '{
                        if (NR == 1) {
                            print $0, fieldName":"
                        } else if (NR==2){
                            print $0 dataType":"
                        }else {
                        print $0 isPrimary":"
                        }
                    }' "$oldMetadata" > "$newMetaData"
                    
                    mv "$newMetaData" "$oldMetadata"
                    echo "Field '$fieldName' added to table '$tableName'."
                else
                    echo "Table '$tableName' does not exist"
                fi
                ;;
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
   		 while true
   		  do
        		read -p "Enter value for $fieldName: " fieldValue
      				  if [[ "$fieldDataType" == "string" && ! "$fieldValue" =~ ^[A-Za-z]+$ ]]
      				  then
         				   echo "Invalid input. '$fieldName' should be a string."
  			        elif [[ "$fieldDataType" == "number" && ! "$fieldValue" =~ ^[0-9]+$ ]]
  			        then
        				    echo "Invalid input. '$fieldName' should be a number."
  			      else
  				          break  
    			    fi
    		  done
   		 echo -n "$fieldValue:" >> "${tableName}.data"
		done
		echo >> "${tableName}.data"
		else 
                    echo "Table '$tableName' does not exist"
              fi      
		;;
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


