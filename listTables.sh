#!/usr/bin/bash

metadataTables=$(ls *.metadata)
dataTables=$(ls *.data)
currentPath=`pwd`
#__________________________________________________________________________________________________________________
#listing tables using ls
while true
do
    echo "=== HN List Menu ==="
    echo "=============================================================="
    listMenu=("List all tables" "List metadata tables" "List data table" "Exit") 
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
                    echo -e "$dataTables""\n""$metadataTables"
                fi
                ;;
            "List metadata tables")
                echo "You selected: $answer"
                if [ ! "$metadataTables" ]
                then
                    echo "There is no metadata tables so no tables created yet"
                else
                    echo "Metadata tables in this database are:"
                    echo "$metadataTables"
                fi
                ;;
            "List data table")
                echo "You selected: $answer"
                if [ ! "$dataTables" ]
                then
                    echo "There is no data tables so no tables of the above filled yet"
                else
                    echo "Data tables in this database are:"
                    echo "$dataTables"
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



