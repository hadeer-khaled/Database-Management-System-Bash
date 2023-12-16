#!/usr/bin/bash

currentPath=$(pwd)
#____________________________________________________________________________________________________________________
#menu for choosing select type
while true
do
    echo "=== HN Select Menu ==="
    echo "=============================================================="
    selectMenu=("Select whole table" "Select whole field" "Select whole row" "Exit")
    select answer in "${selectMenu[@]}"
     do
        case $answer in
#____________________________________________________________________________________________________________________
#cat on the two files to combine them ans show whole table
            "Select whole table")
                echo "You selected: $answer"
                read -p "Please enter the name of the table you want to select: " tableName
                if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
                then
                    cat "$tableName.metadata" "$tableName.data"
                elif [[ -f "$currentPath/$tableName.metadata" && ! -f "$currentPath/$tableName.data" ]]
                then
                    echo "This table is empty"
                    cat "$tableName.metadata"
                else
                    echo "Table '$tableName' not found"
                fi
                ;;
#____________________________________________________________________________________________________________________
#awk on .metadata to get field number then getting the values its contains
          "Select whole field")
 	   echo "You selected: $answer"
  	  read -p "Please enter the name of the table you want to select a field from: " tableName
 	   if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
 	   then
   	     read -p "Please enter the name of the field you want to select from $tableName: " fieldName
   	     fieldNumber=$(echo "$currentPath/$tableName.metadata" | awk -F: -v col="$fieldName" '{for (i=1; i<=NF; i++) if ($i == col) print i}' "$tableName.metadata")
  		      if [[ ${#fieldNumber} -gt 0 ]]
   		     then
       			    awk -F: -v fieldNum="$fieldNumber" '{if (NF >= fieldNum) print $fieldNum}' "$currentPath/$tableName.data"
     		   else
           		 echo "Field '$fieldName' not found in the metadata of '$tableName'."
        		fi
    	else
      	  echo "Table '$tableName' not found"
   	 fi
   	 ;;
#____________________________________________________________________________________________________________________
#awk on .metadata to get field number then reading specific value to get whole row
	"Select whole row")
    	echo "You selected: $answer"
  	read -p "Please enter the name of the table you want to select a row from: " tableName
 	if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
 	 then
 		 read -p "Please enter the name of the field: " fieldName
       		 fieldPosition=$(awk -F: -v field="$fieldName" 'NR==1 {for (i=1; i<=NF; i++) if ($i == field) print i}' "$currentPath/$tableName.metadata")
     		   if [[ $fieldPosition -gt 0 ]]
     		   then
     		 read -p "Please enter the value in row: " rowValue
          		  result=$(awk -F: -v pos="$fieldPosition" -v value="$rowValue" '$(pos) == value {found=1; exit} END {print found}' "$currentPath/$tableName.data")
      			  if [[ $result -eq 0 ]]
      			  then
               			echo "Row  '$rowValue' not found in '$fieldName'."
         		   else
             			   awk -F: -v pos="$fieldPosition" -v value="$rowValue" '$(pos) == value' "$currentPath/$tableName.data"
         	  	 fi
     		  else
       			 echo "Field '$fieldName' not found in  '$tableName'."
      		  fi
  	  else
    		    echo "Table '$tableName' not found"
   	 fi
 	   ;;
            "Exit")
                echo "Exiting program!"
                exit;;
            *) 
                echo "Invalid choice. Please enter a valid option.";;
        esac
        break
    done
done

