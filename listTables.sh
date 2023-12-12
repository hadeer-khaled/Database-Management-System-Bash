#!/usr/bin/bash

metadataTables=$(ls *.metadata)
dataTables=$(ls *.data)
currentPath=`pwd`
while true
do
    echo "=== HN List Menu ==="
    listMenu=("List all tables" "List metadata tables" "List data table" "Show content of specific table" "Exit") 
    select answer in "${listMenu[@]}"
    do
        case $answer in
            "List all tables")
                echo "You selected: $answer"
                if [[ ! "$dataTables" && ! "$metadataTables" ]]
                then
                    echo "There are no tables. Try to create tables to list them."
                else
                    echo "Tables in this database are:"
                    echo "$dataTables"  "$metadataTables"
                fi
                ;;
            "List metadata tables")
                echo "You selected: $answer"
                if [ ! "$metadataTables" ]
                then
                    echo "There is no metadata tables so no tables created yet"
                else
                    MDtables=$(echo "$metadataTables" | sed 's/.metadata//g')
                    echo "Metadata tables in this database are:"
                    echo "$MDtables"
                fi
                ;;
            "List data table")
                echo "You selected: $answer"
                if [ ! "$dataTables" ]
                then
                    echo "There is no data tables so no tables of the above filled yet"
                else
                    Dtables=$(echo "$dataTables" | sed 's/.data//g')
                    echo "Data tables in this database are:"
                    echo "$Dtables"
                fi
                ;;
            "Show content of specific table")
   		 echo "You selected: $answer"
  		  read -p "If you want to see metadata table with data table, please enter the table name to show: " tableName
		 if [[ -f "$currentPath/$tableName.data" && -f "$currentPath/$tableName.metadata" ]]
   		 #! echo "$MDtables" | grep -qw "$tableName"
  		  then
  			      cat "$tableName.metadata" "$tableName.data"
  		elif [[ -f "$currentPath/$tableName.metadata" && ! -f "$currentPath/$tableName.data" ]]
  		then
  		echo "this table is empty .. no content just metadata"
  		cat "$tableName.metadata"
   		 else
     			   echo "Sorry, table not exist"
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



