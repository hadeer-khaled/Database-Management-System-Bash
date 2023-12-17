#!/usr/bin/bash

currecntDirectory=$(pwd) 
while true
do
    echo "=== HN Table Menu ==="
    echo "=============================================================="
    tableMenu=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Update Table" "Delete From Table" "Exit") 
    select answer in "${tableMenu[@]}"
    do
        case $answer in
         "Create Table")
         		 echo "You selected: $answer"
         		createTable.sh
         		;;
            "List Tables") 
            		echo "You selected: $answer"
            		listTables.sh
            		;;
            "Drop Table") 
            		echo "You selected: $answer"
            		dropTable.sh
            		;;
            "Insert into Table") 
            		echo "You selected: $answer"
            		insertIntoTable.sh
            		;;
            "Select From Table")
            		 echo "You selected: $answer"
            		 selectFromTable.sh
            		 ;;
            "Update Table") 
            		echo "You selected: $answer"
            		updateTable.sh
            		;;
            "Delete From Table") 
            		echo "You selected: $answer"
            		deleteFromTable.sh
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

