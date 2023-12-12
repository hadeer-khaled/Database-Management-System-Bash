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
    elif [[ ! "$metaDataTableName" =~ ^[a-zA-Z0-9_] || ${#metaDataTableName} -gt 64 ]]
     then
        echo "Sorry... invalid name. Try another name starting with a letter, number, or underscore and less than 64 character ONLY"
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
            if [[ ! "$columnName" =~ ^[a-zA-Z0-9_] || ${#columnName} -gt 64 ]]
            then
                echo "Sorry... invalid column name. Try another name starting with a letter, number, or underscore."
            elif grep -q -w "$columnName" "${tableNameReplacedSpace}.metadata"
            then
                echo "Sorry... column name '$columnName' already exists. Try another name."
            else
                columnNames+="$columnName:"
                while [ "$flag" != true ]
                do
                    read -p "Please enter column data type for $columnName: " columnDataType
                    case "$columnDataType" in
                        "string" | "number")
                            dataTypes+="$columnDataType:"
                            flag=true
                            ;;
                        *)
                            echo "Invalid data type. Please enter 'string' or 'number'."
                            ;;
                    esac
                done

                flag=false
                while [ "$flag" != true ]
                do
                    read -p "Is $columnName a primary key? (yes/no): " isPrimary
                    case "$isPrimary" in
                        "yes" | "no")
                            primaryKeys+="$isPrimary:"
                            flag=true
                            ;;
                        *)
                            echo "Invalid input. Please enter 'yes' or 'no'."
                            ;;
                    esac
                done
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
            if [[ ! "$columnName" =~ ^[a-zA-Z0-9_] || ${#columnName} -gt 64]]
             then
                echo "Sorry... invalid column name. Try another name starting with a letter, number, or underscore."
            elif grep -q -w "$columnName" "${metaDataTableName}.metadata"
            then
                echo "Sorry... column name '$columnName' already exists. Try another name."
            else
                columnNames+="$columnName:"
                while [ "$flag" != true ]
                do
                    read -p "Please enter column data type for $columnName: " columnDataType
                    case "$columnDataType" in
                        "string" | "number")
                            dataTypes+="$columnDataType:"
                            flag=true
                            ;;
                        *)
                            echo "Invalid data type. Please enter 'string' or 'number'."
                            ;;
                    esac
                done

                flag=false
                while [ "$flag" != true ]
                do
                    read -p "Is $columnName a primary key? (yes/no): " isPrimary
                    case "$isPrimary" in
                        "yes" | "no")
                            primaryKeys+="$isPrimary:"
                            flag=true
                            ;;
                        *)
                            echo "Invalid input. Please enter 'yes' or 'no'."
                            ;;
                    esac
                done
            fi
        done
    done

    echo -n "$columnNames" >> "${metaDataTableName}.metadata"
    echo >> "${metaDataTableName}.metadata"
    echo -n "$dataTypes" >> "${metaDataTableName}.metadata"
    echo >> "${metaDataTableName}.metadata"
    echo "$primaryKeys" >> "${metaDataTableName}.metadata"
fi


