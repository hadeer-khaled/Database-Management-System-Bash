#!/usr/bin/bash


metadataTables=$( ls *.metadata )
read -p "Please enter the table name you want to drop: " tableName
if [ ! -e "${tableName}.metadata" ]
   	then
        echo "Sorry... table with name not exists to drop"
else
    read -p "Do you really want to drop the table '$tableName'? (yes/no): " confirmation
    if [ "$confirmation" == "yes" ]
     then
        rm "$tableName.data"
        echo "Data file '$tableName.data' removed successfully."
    else
        echo "Table '$tableName' not dropped."
    fi
fi
