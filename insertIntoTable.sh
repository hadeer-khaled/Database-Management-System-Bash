#!/usr/bin/bash
rightSign='\xE2\x9C\x94'
crossSign='\xE2\x9D\x8C'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
#____________________________________________________________________________________________________________________
while true
do
	echo -e "${YELLOW}=== H&N Insert Menu ===${NC}"
	echo -e "${YELLOW}==============================================================${NC}"
	insertMenu=("Insert new Field" "Insert new row" "Exit")
	select answer in "${insertMenu[@]}"
    do
        case $answer in
#____________________________________________________________________________________________________________________
#menu for choosing insert new column
"Insert new Field")
    pkFlag=false
    echo -e "${GREEN}You selected: $answer${NC}"
    read -p "Please enter table name: " tableName

    if [ -f "${tableName}.metadata" ]
    then
        read -p "Please enter field name: " fieldName

        while [[ ! "$fieldName" =~ ^[a-zA-Z][a-zA-Z0-9_] || ${#fieldName} -gt 64 ]]
         do
            echo -e "${RED}Sorry... invalid field name. Try another name starting with a letter, or underscore.and BE CAREFUL to be less than 64 character ${NC}"
            read -p "Please enter field name for the new field: " fieldName
        done

        read -p "Please enter data type (string or number): " dataType

        while [[ "$dataType" != "string" && "$dataType" != "number" ]]
         do
            echo -e "${RED}Invalid data type. Enter 'string' or 'number'. ${NC}"
            read -p "Please enter data type (string or number): " dataType
        done
	
        existingPKs=$(awk -F: 'NR=3 {print $'$((fieldNumber+1))'}' "${tableName}.metadata" | tr '\n' ' ')

        while [ "$pkFlag" != "true" ]
         do
            read -p "Is $fieldName a primary key? (yes/no): " isPrimary
            if [[ "$isPrimary" == "yes" ]]
            then
                if [[ $counter -eq 0 && ! $(grep -o -w "yes" <<< "$primaryKeys") ]]
                then
                    primaryKeys+="$isPrimary:"
                    counter=$((counter + 1))
                    pkFlag=true
                else
                    echo -e  "${RED}Sorry... can't add more than one unique PK in the same table or duplicate primary key value${NC}"
                    pkFlag=false
                fi
            elif [[ "$isPrimary" == "no" ]]
            then
                primaryKeys+="$isPrimary:"
                pkFlag=true
            else 
                echo -e "${RED}Invalid input. Please enter 'yes' or 'no' for primary key.${NC}"

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
        echo  -e "${GREEN}Field '$fieldName' added to table '$tableName'.${NC}"
    else
        echo -e "${RED}Table '$tableName' does not exist ${NC}"
    fi
    ;;


#____________________________________________________________________________________________________________________
#menu for choosing insert  new row (data)

"Insert new row")
    echo -e "${GREEN}You selected: $answer${NC}"
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
            		        echo -e "${RED}Do not enter null in pk !${NC} "
            		                       var=0
				else
				fieldValue=0
				fi
                 elif [[ "$fieldDataType" == "string" && -z "$fieldValue" ]]
                 then
                                 if [  "$fieldsPrimary" == "yes"  ]
            		        then
            		                    		        echo -e "${RED}Do not enter null in pk !${NC} "
            		        var=0
				else
				fieldValue=null
				fi
                elif [[ "$fieldDataType" == "string" && ! "$fieldValue" =~ ^[A-Za-z]+$ ]]
                then
                    echo -e "${RED}Invalid input. '$fieldName' should be a string.${NC}"
                    var=0
                elif [[ "$fieldDataType" == "number" && ! "$fieldValue" =~ ^[0-9]+$ ]]
                 then
                    echo -e "${RED}Invalid input. '$fieldName' should be a number.${NC}"
                    var=0
                else
                    if [ "$fieldsPrimary" == "yes" ]
                    then
                        for val in "${existingValues[@]}"
                        do
                            if [ "$val" == "$fieldValue" ]
                            then
                                echo -e "${RED}Error: Value for primary key column '$fieldName' must be unique.${NC}"
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
                    echo -e  "${GREEN}Value '$fieldValue' added for column '$fieldName'.${NC}"
        done
        echo >> "${tableName}.data"
    else
        echo  -e "${RED}Table '$tableName' does not exist.${NC}"
    fi
    ;;
#____________________________________________________________________________________________________________________
            "Exit")
                echo -e "${GREEN}Exiting program!${NC}"
                exit;;
            *)
                echo -e  "${RED}Invalid choice. Please enter a valid option.${NC}"
                ;;
        esac
        break
    done
done
