#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

read -p "Enter the Table Name you want to delete from: " tableName
dataFile=$tableName.data

while ! [ -e $dataFile ];
do
	echo ">> This table name dosn't exist. Try again"
	read -p "Enter the Table Name you want to delete from: " tableName
	dataFile=$tableName.data
done
metaDataFile=$tableName.metadata
header=`head -n 1 $metaDataFile`

#---------------------------------------------------------------------------------#

PS3="choose what want to delete "
deleteActions=("Delete Column" "Delete Row" "Delete Entire Data" "Exit")
select action in "${deleteActions[@]}";
	do    
	case $REPLY in
				    
		1 | [Dd][Ee][Ll][Ee][Tt][Ee][[:space:]][Cc][Oo][Ll][Uu][Mm][Nn])
		read -p "Enter the column name that you want to delete: " delColumnName
		
		delColumnNumber=$(echo "$header" | awk -F: -v delColumnName="$delColumnName" '{for(i=1; i<=NF; i++) if($i == delColumnName) print i}')
		
		
		#-------------- Check if column name dosn't exist -------------#
		while [ -z "$delColumnNumber" ]; 
		do	
			echo ">> This column name dosn't exist. Try again"
			read -p "Enter the Column Name you want to delete it: " delColumnName  
		delColumnNumber=$(echo "$header" | awk -F: -v delColumnName="$delColumnName" '{for(i=1; i<=NF; i++) if($i == delColumnName) print i}')
		done
		
		#-------------- Check if column name is PK -------------#
		IFS=: read -a PKsArray < <(sed -n '3p' "$metaDataFile") 

		if [ ${PKsArray[$(($delColumnNumber-1))]} ==  "yes" ];
		then
			echo ">>This column is primary Key so you cannot delete it"
		
		else
			delTempFile=$(mktemp)
			awk -v col="$delColumnNumber" 'BEGIN {FS=OFS=":"} {$col="null";""} 1' "$dataFile"> "$delTempFile"  
			mv "$delTempFile" "$dataFile"
			rm -f "$delTempFile"
			
			echo "Data of $delColumnName column is deleted successfully. "
		fi
			;;
			
		2 | [Dd][Ee][Ll][Ee][Tt][Ee][[:space:]][Rr][Oo][Ww])
			#------------------------------------- Check if the whereColumnName exists -------------------------------------#

			read -p "Enter the Condition Column: " whereColumnName  

			CondColumnNumber=$(echo "$header" | awk -F: -v whereColumnName="$whereColumnName" '{for(i=1; i<=NF; i++) if($i == whereColumnName) print i}')

			while [ -z "$CondColumnNumber" ]; 
			do	
				echo ">> This column name dosn't exist. Try again"
				read -p "Enter the Condition Column: " whereColumnName   
				CondColumnNumber=$(echo "$header" | awk -F: -v whereColumnName="$whereColumnName" '{for(i=1; i<=NF; i++) if($i == whereColumnName) print i}')

			done
			
			read -p "Enter the Condition Value: " whereValue 
			
			if grep -q "$whereValue" "$dataFile"; then
				
				delTempFile=$(mktemp)
				
				awk -v whereValue="$whereValue" -v CondColumnNumber="$CondColumnNumber"  -F: '$CondColumnNumber != whereValue' "$dataFile" > "$delTempFile"
				
				mv "$delTempFile" "$dataFile"
				
				rm -f "$delTempFile"
				echo "Row with $whereColumnName = $whereValue is deleted successfully. "
			fi

			;;	
							
		3| [Dd][Ee][Ll][Ee][Tt][Ee][[:space:]][Ee][Nn][Tt][Ii][Rr][Ee][Dd][Aa][Tt][Aa])
			read -p  "Do you want to delete entire table data ? (yes/no)" ans
			ans_lowercase=$(echo "$ans" | tr '[:upper:]' '[:lower:]')
			if [ "$ans_lowercase" == "yes" ];
			then 
				echo -n > "$dataFile"
				echo "Entire Table Data is deleted successfully."
			fi
			;;
				    
		4 | [Ee][Xx][Ii][Tt] )
			break
			;;
		* ) 
			echo "Invalid Action"
			;;
	esac
					
	done 	
