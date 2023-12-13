#!/usr/bin/bash

#need to combine two files to have hole table
#from combination select hole table 
#from combination select hole column
#from combination select hole row

currentPath=`pwd`

#read -p "If you want to see metadata table with data table, please enter the table name to show: " tableName
#cat "$tableName.metadata" "$tableName.data"

while true
do
    echo "=== HN Select Menu ==="
    selectMenu=("Select hole table " "Select hole column" "Select hole row" "Exit") 
    select answer in "${selectMenu[@]}"
    do
        case $answer in
        "Select hole table ")
   		 echo "You selected: $answer"
  		  read -p "PLease enter the name of table you want to select: " tableName
		 if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
  		  then
  			      cat "$tableName.metadata" "$tableName.data"
  		elif [[ -f "$currentPath/$tableName.metadata" && ! -f "$currentPath/$tableName.data" ]]
  		then
  		echo "this table is empty .. no content just metadata"
  		cat "$tableName.metadata"
   		 else
     			   echo "Sorry, there is no tables with this name"
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



