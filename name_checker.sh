#!/bin/bash
shopt -s extglob


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


: '
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
'
