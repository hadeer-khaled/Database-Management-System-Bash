#!/bin/bash
shopt -s extglob
currentPath=`pwd`

# check if DB dir exit or not.
if [ ! -d "$currentPath/BD" ];
then 
    mkdir "$currentPath/BD"
fi

cd $currentPath/BD
#echo "Your path now is: `pwd`"

#-----------------------------------------
#echo "the file path $0"
#script_directory=$(dirname $0)
#echo $script_directory
#---------------------------
#----------------------------------- create selcet menu ------------------------------------
PS3="choose an action to do: "

actions=("Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit")
select action in "${actions[@]}";
	do    
	export flag=1
	export DB_Name=" "
		case $REPLY in
			################################# Create the databse ################################
		    1 | [Cc][Rr][Ee][Aa][Tt][Ee][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )

			read -p "Enter database name: " DB_Name
			
			
			source name_checker.sh

			if (( flag == 1 ))
			then 
				if [ -d "$currentPath/BD/$DB_Name" ]
				then
					echo ">>>>>>>>> Error: This Database already exists"
				else
					mkdir "$currentPath/BD/$DB_Name"
					echo "$DB_Name database is created"   
				fi
			fi
			
			;;	
			
			################################# List available databases ################################	
		    2 | [Ll][Ii][Ss][Tt][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			echo "The available databases are: "
			ls  "$currentPath/BD" 
			;;
			
			################################# Connect to a databases ################################	
		    3 | [Cc][Oo][Nn][Nn][Ee][Cc][Tt][[:space:]][Tt][Oo][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
		    
		        read -p "Enter database name: " DB_Name
		        source name_checker.sh
		        if (( flag == 1 ))
		        then
				if [ -d "$currentPath/BD/$DB_Name" ]
				then
					 cd "./$DB_Name"
					 echo "Your path now is: `pwd` " 

				else
					echo "This Database doesn't exist"  
				fi
			fi	
			;;
			
			################################# Drop a databases ################################	
		    4 | [Dd][Rr][Oo][Pp][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			read -p "Enter database name: " DB_Name
			source name_checker.sh
		        if (( flag == 1 ))
		        then
				if [ -d "$currentPath/BD/$DB_Name" ]
				then
					
					rm -r "$currentPath/BD/$DB_Name" 
					echo "$DB_Name is deleted successfully."
				else
					echo "This Database doesn't exist"  
				fi
		        fi 
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
	
