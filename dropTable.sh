#!/usr/bin/bash


#_________________________________________________________________________________________________
#drop table with two ways whole or just data file and take confirmation from user
read -p "Please enter the table name you want to drop: " tableName
if [ ! -e "${tableName}.metadata" ]
   	then
        echo "Sorry... table with name '$tableName' not exists to drop"
else
   	read -p "Do you really want to drop the table '$tableName'? (yes/no): " confirmation
	if [ "$confirmation" == "yes" ]
 	then
  	  list=("whole table" "data file only" "Exit") 
 	select answer in "${list[@]}"
   	 do
    	  	case $answer in
     	       "whole table")
                metadataTables=$( ls *.metadata )
                dataTables=$( ls *.data )
                rm "$tableName.data" "$tableName.metadata"
                echo "Data file '$tableName.data' and '$tableName.metadata' removed successfully."
                ;;
            "data file only")
                dataTables=$( ls *.data )
                rm "$tableName.data"
                echo "Data file '$tableName.data' removed successfully."
                ;;
            "Exit")
                echo "Exiting program!"
                exit;;
            *) 
                echo "Invalid choice. Please enter a valid option.";;
        esac
        break
    done
else
    echo "Table '$tableName' not dropped."
fi
fi
