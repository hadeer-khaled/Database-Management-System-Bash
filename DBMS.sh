#!/bin/bash
######################################################
# "${actions[@]}"
# [[:space:]]
#####################################################
currentPath=`pwd`

# check if DB dir exit or not.
if [ ! -d "$currentPath/BD" ];
then 
    mkdir "$currentPath/BD"
fi

cd $currentPath/BD

#----------------------------------- create selcet menu ------------------------------------
echo "choose an action to do"

actions=("Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit")
select action in "${actions[@]}";
	do    
		case $REPLY in
		    1 | [Cc][Rr][Ee][Aa][Tt][Ee][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			echo "Create Database"
			;;
		    2 | [Ll][Ii][Ss][Tt][[:space:]][Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee] )
			echo "List Databases"
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
