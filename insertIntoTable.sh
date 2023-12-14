#!/usr/bin/bash

insertMenu=("Insert new Column" "Insert new row" "Exit")

while true
do
    echo "=== Insert Menu ==="
    select answer in "${insertMenu[@]}"
    do
        case $answer in
            "Insert new Column")
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
                            print $0, fieldName ":"
                        } else if (NR==2){
                            print $0 dataType ":"
                        }else {
                        print $0 isPrimary ":"
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


               

