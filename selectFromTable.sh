#!/usr/bin/bash

currentPath=$(pwd)

while true
do
    echo "=== HN Select Menu ==="
    selectMenu=("Select hole table" "Select hole column" "Select hole row" "Exit")
    select answer in "${selectMenu[@]}"
     do
        case $answer in
            "Select hole table")
                echo "You selected: $answer"
                read -p "Please enter the name of the table you want to select: " tableName
                if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
                then
                    cat "$tableName.metadata" "$tableName.data"
                elif [[ -f "$currentPath/$tableName.metadata" && ! -f "$currentPath/$tableName.data" ]]
                then
                    echo "This table is empty .. no content, just metadata"
                    cat "$tableName.metadata"
                else
                    echo "Table '$tableName' not found or incomplete (missing metadata or data file)."
                fi
                ;;
          "Select hole column")
 	   echo "You selected: $answer"
  	  read -p "Please enter the name of the table you want to select a column from: " tableName
 	   if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
 	   then
    	    metadata=$(<"$tableName.metadata")
   	     read -p "Please enter the name of the column you want to select from $tableName: " columnName
   	     columnNumber=$(echo "$metadata" | awk -F: -v col="$columnName" '{for (i=1; i<=NF; i++) if ($i == col) print i}')
  		      if [[ ${#columnNumber} -gt 0 ]]
   		     then
       			    awk -F: -v colNum="$columnNumber" '{if (NF >= colNum) print $colNum}' "$currentPath/$tableName.data"
     		   else
           		 echo "Column '$columnName' not found in the metadata of '$tableName'."
        		fi
    	else
      	  echo "Table '$tableName' not found or incomplete (missing metadata or data file)."
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

