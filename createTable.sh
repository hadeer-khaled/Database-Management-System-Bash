#!/usr/bin/bash

echo "______________________________________________________________________________"
echo -e "Hello And Welcome To H&N Database Administration System.\nLet's Start To Create Table"
echo "______________________________________________________________________________"
flag=false
while [ "$flag" != true ]
do
    read -p "Please enter a table name to create: " metaDataTableName
    if [ -e "${metaDataTableName}.metadata" ]
    then
        echo "Sorry... table with name '$metaDataTableName' already exists. Try another name."
    elif [[ ! "$metaDataTableName" =~ ^[a-zA-Z0-9_] ]]
    then
        echo "Sorry... invalid name. Try another name starting with a letter, number, or underscore ONLY"
    else
        flag=true
    fi
done

if echo "$metaDataTableName" | grep -q ' '
then
    tableNameReplacedSpace=$(echo "$metaDataTableName" | sed 's/ /_/g')
    touch "${tableNameReplacedSpace}.metadata"
    echo "Table with name '$tableNameReplacedSpace' created successfully"
    read -p "Please enter the number of columns you want to enter: " columnNumber
    columnNames=""
    dataTypes=""
    primaryKeys=""
    for ((i=1; i<=columnNumber; i++))
    do
        flag=false
        while [ "$flag" != true ]
        do
            read -p "Please enter column name for column $i: " columnName
            if [[ ! "$columnName" =~ ^[a-zA-Z0-9_] ]]
            then
                echo "Sorry... invalid column name. Try another name starting with a letter, number, or underscore."
            elif grep -q -w "$columnName" "${tableNameReplacedSpace}.metadata"
            then
                echo "Sorry... column name '$columnName' already exists. Try another name."
            elif echo "$columnName" | grep -q ' '
             then
                columnNameReplacedSpace=$(echo "$columnName" | sed 's/ /_/g')
                columnNames+="$columnNameReplacedSpace:"
                read -p "Please enter column data type for $columnName: " columnDataType
                dataTypes+="$columnDataType:"
                read -p "Is $columnName a primary key? (yes/no): " isPrimary
                primaryKeys+="$isPrimary:"
                flag=true
            else
                columnNames+="$columnName:"
                read -p "Please enter column data type for $columnName: " columnDataType
                dataTypes+="$columnDataType:"
                read -p "Is $columnName a primary key? (yes/no): " isPrimary
                primaryKeys+="$isPrimary:"
                flag=true
            fi
        done
    done

    echo -n "$columnNames" >> "${tableNameReplacedSpace}.metadata"
    echo >> "${tableNameReplacedSpace}.metadata"
    echo -n "$dataTypes" >> "${tableNameReplacedSpace}.metadata"
    echo >> "${tableNameReplacedSpace}.metadata"
    echo "$primaryKeys" >> "${tableNameReplacedSpace}.metadata"
else
    touch "${metaDataTableName}.metadata"
    echo "Table with name '$metaDataTableName' created successfully"

    read -p "Please enter the number of columns you want: " columnNumber
    columnNames=""
    dataTypes=""
    primaryKeys=""

    for ((i=1; i<=columnNumber; i++))
     do
        flag=false
        while [ "$flag" != true ]
        do
            read -p "Please enter column name for column $i: " columnName
            if [[ ! "$columnName" =~ ^[a-zA-Z0-9_] ]]
            then
                echo "Sorry... invalid column name. Try another name starting with a letter, number, or underscore."
            elif grep -q -w "$columnName" "${metaDataTableName}.metadata"
            then
                echo "Sorry... column name '$columnName' already exists. Try another name."
            elif echo "$columnName" | grep -q ' '
             then
                columnNameReplacedSpace=$(echo "$columnName" | sed 's/ /_/g')
                columnNames+="$columnNameReplacedSpace:"
                read -p "Please enter column data type for $columnName: " columnDataType
                dataTypes+="$columnDataType:"
                read -p "Is $columnName a primary key? (yes/no): " isPrimary
                primaryKeys+="$isPrimary:"
                flag=true
            else
                columnNames+="$columnName:"
                read -p "Please enter column data type for $columnName: " columnDataType
                dataTypes+="$columnDataType:"
                read -p "Is $columnName a primary key? (yes/no): " isPrimary
                primaryKeys+="$isPrimary:"
                flag=true
            fi
        done
    done

    echo -n "$columnNames" >> "${metaDataTableName}.metadata"
    echo >> "${metaDataTableName}.metadata"
    echo -n "$dataTypes" >> "${metaDataTableName}.metadata"
    echo >> "${metaDataTableName}.metadata"
    echo "$primaryKeys" >> "${metaDataTableName}.metadata"
fi





                    
                    
                    
                    
                    
                    
                    

<<comment
read -p "please enter a table name to create: " mataDataTableName

if [ -e "$mataDataTableName" ]
    then
    echo " sorry ... table with name '$mataDataTableName' is exists. try another name"
else
    if [[ ! "$mataDataTableName" =~ ^[a-zA-Z0-9_] ]]
    	then
        echo "sorry ... invalid name try another name start with a letter or number or underscore"
    elif echo "$mataDataTableName" | grep -q ' '
    	then
        tableNameReplacedSpace=$(echo "$mataDataTableName" | sed 's/ /_/g')
        touch "$tableNameReplacedSpace"
        echo "table with name '$tableNameReplacedSpace' created successfully"
        read -p "please enter number of columns you want" columnNumber
        for ((i=1; i<=columnNumber; i++))
            do
            read -p "please enter column name for column $i: " columnName
            if [[ ! "$columnName" =~ ^[a-zA-Z0-9] ]]
            	then
                echo "sorry ... invalid column name try another name start with letter or number or underscore"
            elif echo "$columnName" | grep -q ' '
            	then
                columnNameReplacedSpace=$(echo "$columnName" | sed 's/ /_/g')
                echo -n "$columnName:" >> "$tableNameReplacedSpace"
            else
                echo -n "$columnName:" >> "$tableNameReplacedSpace"
            fi
        done
    else
        touch "$mataDataTableName"
        echo "table with name '$mataDataTableName' created successfully"
        read -p "please enter number of columns you want" columnNumber
        for ((i=1; i<=columnNumber; i++))
            do
            read -p "please enter column name for column $i: " columnName
            if [[ ! "$columnName" =~ ^[a-zA-Z0-9] ]]
            	then
                echo "sorry ... invalid column name try another name start with letter or number or underscore"
            elif echo "$columnName" | grep -q ' '
            	then
                columnNameReplacedSpace=$(echo "$columnName" | sed 's/ /_/g')
                echo -n "$columnName:" >> "$mataDataTableName"
            else
                echo -n "$columnName:" >> "$mataDataTableName"
            fi
        done
    fi
fi
comment


<<comment
read -p "please enter a table name to create: " mataDataTableName

if [ -e "$mataDataTableName" ]
	then
    		echo " sorry ... table with name '$mataDataTableName' is exists. try another name"
else
	if [[ ! "$mataDataTableName" =~ ^[a-zA-Z0-9_] ]]
	    then
    		echo "sorry ... invalid name try another name start with a letter or number or 		   underscore"
 	elif echo "$mataDataTableName" | grep -q ' '
 	    then
	        tableNameReplacedSpace=$(echo "$mataDataTableName" | sed 's/ /_/g')
	        touch "$tableNameReplacedSpace"
	        echo "table with name '$tableNameReplacedSpace' created successfully"
	        read -p "please enter number of columns you want" columnNumber
                for ((i=1; i<=columnNumber; i++))
                do
       			     read -p "please enter column name for column $i: " columnName   
       			     if [[ !  "$columnName" =~ ^[a-zA-Z0-9] ]]
       			     	then
       			     		echo "sorry ... invalid column name try another name start with letter or 						number or underscore "
       			     	elif echo "$columnName" | grep -q ' '
       			     		then
       			     			columnNameReplacedSpace=$(echo "$columnName"|sed 's/ /_/g')
       			     			echo -n "$columnName:"  >>"$tableNameReplacedSpace"
       			     	else 
       						echo -n "$columnName:"  >>"$tableNameReplacedSpace"

       		 done
       else
         	 touch "$mataDataTableName"
        	echo "table with name '$mataDataTableName' created successfully"
                read -p "please enter number of columns you want" columnNumber
                for ((i=1; i<=columnNumber; i++))
                do
       			     read -p "please enter column name for column $i: " columnName   
       			     if [[ ! "$columnName" =~ ^[a-zA-Z0-9] ]]
       			     	then
       			     		echo "sorry ... invalid column name try another name start with letter or 						number or underscore "
       			     	elif echo "$columnName" | grep -q ' '
       			     		then
       			     			columnNameReplacedSpace=$(echo "columnName"|sed 's/ /_/g')
       			     			echo -n "$columnName:"  >>"$mataDataTableName"
       			     	else 
       						echo -n "$columnName:"  >>"$mataDataTableName"

       		 done
    fi
fi
comment


<<comment
#!/bin/bash

read -p "Please enter a table name to create: " metaDataTableName

if [ -e "$metaDataTableName" ]; then
    echo "Sorry... table with name '$metaDataTableName' already exists. Try another name."
else
    if [[ ! "$metaDataTableName" =~ ^[a-zA-Z0-9_] ]]; then
        echo "Sorry... invalid name. Try another name starting with a letter, number, or underscore."
    elif echo "$metaDataTableName" | grep -q ' '; then
        tableNameReplacedSpace=$(echo "$metaDataTableName" | sed 's/ /_/g')
        touch "$tableNameReplacedSpace.metadata"
        echo "Table with name '$tableNameReplacedSpace' created successfully"

        read -p "Please enter the number of columns you want: " columnNumber
        for ((i=1; i<=columnNumber; i++)); do
            while true; do
                read -p "Please enter column name for column $i: " columnName
                if [[ ! "$columnName" =~ ^[a-zA-Z0-9_] ]]; then
                    echo "Sorry... invalid column name. Try another name starting with a letter, number, or underscore."
                elif grep -q -w "$columnName" "$tableNameReplacedSpace.metadata"; then
                    echo "Sorry... column name '$columnName' already exists. Try another name."
                elif echo "$columnName" | grep -q ' '; then
                    columnNameReplacedSpace=$(echo "$columnName" | sed 's/ /_/g')
                    read -p "Is $columnName a primary key? (yes/no): " isPrimary
                    echo -n "$columnNameReplacedSpace:$isPrimary " >> "$tableNameReplacedSpace.metadata"
                    read -p "Please enter column data type for $columnName: " columnDataType
                    echo "$columnDataType" >> "$tableNameReplacedSpace.metadata"
                    break
                else
                    read -p "Is $columnName a primary key? (yes/no): " isPrimary
                    echo -n "$columnName:$isPrimary " >> "$tableNameReplacedSpace.metadata"
                    read -p "Please enter column data type for $columnName: " columnDataType
                    echo "$columnDataType" >> "$tableNameReplacedSpace.metadata"
                    break
                fi
            done
        done

    else
        touch "$metaDataTableName.metadata"
        echo "Table with name '$metaDataTableName' created successfully"

        read -p "Please enter the number of columns you want: " columnNumber
        for ((i=1; i<=columnNumber; i++)); do
            while true; do
                read -p "Please enter column name for column $i: " columnName
                if [[ ! "$columnName" =~ ^[a-zA-Z0-9_] ]]; then
                    echo "Sorry... invalid column name. Try another name starting with a letter, number, or underscore."
                elif grep -q -w "$columnName" "$metaDataTableName.metadata"; then
                    echo "Sorry... column name '$columnName' already exists. Try another name."
                elif echo "$columnName" | grep -q ' '; then
                    columnNameReplacedSpace=$(echo "$columnName" | sed 's/ /_/g')
                    read -p "Is $columnName a primary key? (yes/no): " isPrimary
                    echo -n "$columnNameReplacedSpace:$isPrimary " >> "$metaDataTableName.metadata"
                    read -p "Please enter column data type for $columnName: " columnDataType
                    echo "$columnDataType" >> "$metaDataTableName.metadata"
                    break
                else
                    read -p "Is $columnName a primary key? (yes/no): " isPrimary
                    echo -n "$columnName:$isPrimary " >> "$metaDataTableName.metadata"
                    read -p "Please enter column data type for $columnName: " columnDataType
                    echo "$columnDataType" >> "$metaDataTableName.metadata"
                    break
                fi
            done
        done
    fi
fi
comment


