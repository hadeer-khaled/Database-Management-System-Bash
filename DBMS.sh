#!/bin/bash
shopt -s extglob
currentPath=`pwd`

# check if DB dir exit or not.
if [ ! -d "$currentPath/BD" ];
then 
    mkdir "$currentPath/BD"
fi

cd $currentPath/BD

#----------------------------------- create selcet menu ------------------------------------
PS3="choose an action to do: "

actions=("Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit")
select action in "${actions[@]}";
	do    
		case $REPLY in
		    1 | [Cc][Rr][Ee][Aa][Tt][Ee][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )

			read -p "Enter database name: " DB_Name
			
			if [ -d "$currentPath/BD/$DB_Name" ]
			then
				echo ">>>>>>>>> Error: This Database already exists"
			else
				mkdir "$currentPath/BD/$DB_Name"
				echo "$DB_Name database is created"   
			fi
			
			;;		
		    2 | [Ll][Ii][Ss][Tt][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			echo "The availabl databases are: "
			ls  "$currentPath/BD" 
			;;
		    3 | [Cc][Oo][Nn][Nn][Ee][Cc][Tt][[:space:]][Tt][Oo][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			echo "Connect to Database"
			;;
		    4 | [Dd][Rr][Oo][Pp][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			echo "Drop Database"
			;;
		    5 | [Ee][Xx][Ii][Tt] )
			break
			;;
		    * ) 
			echo "Invalid Action"
			;;
		esac				
	done 
	
: '
########################### start with number ###########################

if [ $"DB_Name"~^[0-9] ];
then 
	echo "Error: Database name cannot start with a number."
fi
'	
	
