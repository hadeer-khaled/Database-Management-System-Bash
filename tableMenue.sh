#!/usr/bin/bash

currecntDirectory=$(pwd) 
while true; do
    echo "=== HN Table Menu ==="
    tableMenu=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Update Table" "Delete From Table" "Exit") 

    select answer in "${tableMenu[@]}"
    do
        case $answer in
         "Create Table")
         		 echo "You selected: $answer"
         		#$currecntDirectory/createTable.sh;;
            "List Tables") 
            		echo "You selected: $answer";;
            		#~$currecntDirectory/listTable.sh
            "Drop Table") 
            		echo "You selected: $answer";;
            		#$currecntDirectory/dropTable.sh
            "Insert into Table") 
            		echo "You selected: $answer";;
            "Select From Table")
            		 echo "You selected: $answer";;
            "Update Table") 
            		echo "You selected: $answer";;
            "Delete From Table") 
            		echo "You selected: $answer";;
            "Exit") 
            		echo "Exiting program!"; exit;;
            *) echo "Invalid choice. Please enter a valid option.";;
        esac
        break
    done
done

