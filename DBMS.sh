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
	flag=1
		case $REPLY in
		    1 | [Cc][Rr][Ee][Aa][Tt][Ee][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )

			read -p "Enter database name: " DB_Name
			
			#-------------------------- Check the name length--------------------------#
			if [ ${#DB_Name} -le 1 -o ${#DB_Name} -ge 10 ]
			then 
				echo ">>>>>>>>> Error: Database name length should be from 1 to 64 characters."
				flag=0
			fi    	
							
			#-------------------------- Check for spaces --------------------------#
			if [[ $DB_Name =~ [[:space:]] ]]
			then 
				echo ">>>>>>>>> Warning: Database name cannot contain spaces, the spaces will be replaced with uderscore(_)"
				echo ">>>>>>>>> The database name will be \"${DB_Name// /_}\" instead of \"$DB_Name\" "
				DB_Name=${DB_Name// /_}									
			fi
			
			#-------------------------- Check for sepecial charachters OR if start with number OR if start with (_) --------------------------#
			if ! [[ $DB_Name =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]
			then 
				echo ">>>>>>>>> Error: Database name can contain letters, uderscore and numbers only. But not start with number or uderscore"
				flag=0 
			fi
			################################# Create the databse ################################
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
		    2 | [Ll][Ii][Ss][Tt][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			echo "The availabl databases are: "
			ls  "$currentPath/BD" 
			;;
			# connect database	
		    3 | [Cc][Oo][Nn][Nn][Ee][Cc][Tt][[:space:]][Tt][Oo][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
		    
		        read -p "Enter database name: " DB_Name
			if [ -d "$currentPath/BD/$DB_Name" ]
			then
				 ## cd to  $currentPath/DB/$DB_Name
				 ## let prompt at the new path
			else
				echo "This Database don't exist"  
			fi	
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
	
