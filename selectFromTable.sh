#!/usr/bin/bash

currentPath=$(pwd)

while true
do
    echo "=== HN Select Menu ==="
    selectMenu=("Select whole table" "Select whole column" "Select whole row" "Exit")
    select answer in "${selectMenu[@]}"
     do
        case $answer in
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
          "Select whole column")
 	   echo "You selected: $answer"
  	  read -p "Please enter the name of the table you want to select a column from: " tableName
 	   if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
 	   then
   	     read -p "Please enter the name of the column you want to select from $tableName: " columnName
   	     columnNumber=$(echo "$metadata" | awk -F: -v col="$columnName" '{for (i=1; i<=NF; i++) if ($i == col) print i}' "$tableName.metadata")
  		      if [[ ${#columnNumber} -gt 0 ]]
   		     then
       			    awk -F: -v colNum="$columnNumber" '{if (NF >= colNum) print $colNum}' "$currentPath/$tableName.data"
     		   else
           		 echo "Column '$columnName' not found in the metadata of '$tableName'."
        		fi
    	else
      	  echo "Table '$tableName' not found"
   	 fi
   	 ;;
	"Select whole row")
    	echo "You selected: $answer"
  	read -p "Please enter the name of the table you want to select a row from: " tableName
 	if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
 	 then
 		 read -p "Please enter the name of the column: " columnName
       		 colPosition=$(awk -F: -v col="$columnName" 'NR==1 {for (i=1; i<=NF; i++) if ($i == col) print i}' "$currentPath/$tableName.metadata")
     		   if [[ $colPosition -gt 0 ]]
     		   then
     		 read -p "Please enter the value in row: " rowValue
          		  result=$(awk -F: -v pos="$colPosition" -v value="$rowValue" '$(pos) == value {found=1; exit} END {print found}' "$currentPath/$tableName.data")
      			  if [[ $result -eq 0 ]]
      			  then
               			echo "Row  '$rowValue' not found in '$columnName'."
         		   else
             			   awk -F: -v pos="$colPosition" -v value="$rowValue" '$(pos) == value' "$currentPath/$tableName.data"
         	  	 fi
     		  else
       			 echo "Column '$columnName' not found in  '$tableName'."
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

