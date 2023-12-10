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
			
			########################### length 1->64 characters ######################
			
		        if [ ${#DB_Name} -le 1 -o ${#DB_Name} -ge 10 ]
		        then 
                		echo ">>>>>>>>> Error: Database name length should be from 1 to 64 characters."
            		fi    					
			########################### check for space ######################
			if [[ $DB_Name =~ [[:space:]] ]]
			then 
				echo ">>>>>>>>> Warning: Database name cannot contain spase, the spase will be replaced with uderscore(_)"
				echo ">>>>>>>>> $DB_Name will be ${DB_Name// /_}"
				DB_Name=${DB_Name// /_}									
			fi
			########################### check for sepecial charachters , not start with number , not start with _ ###########################
			if ! [[ $DB_Name =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]
			then 
				echo ">>>>>>>>> Error: Database name can contain letters, uderscore and numbers only. But not start with number or uderscore"
			fi
			#############################################################
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
	
