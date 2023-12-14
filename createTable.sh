#!/usr/bin/bash

echo "______________________________________________________________________________"
echo -e "Hello And Welcome To H&N Database Administration System.\nLet's Start To Create Table"
echo "______________________________________________________________________________"
flag=false
while [ "$flag" != true ]
do
    read -p "Please enter a table name to create: " tableName
    if [ -e "${tableName}.metadata" ]
    then
        echo "Sorry... table with name '$tableName' already exists. Try another name."
    elif [[ ! "$tableName" =~ ^[a-zA-Z][a-zA-Z0-9_] ]]
     then
        echo "Sorry... invalid name. Try another name starting with a letter, number, or underscore and less than 64 character ONLY"
    else
        flag=true
    fi
done

if echo "$tableName" | grep -q ' '
 then
    tableNameReplacedSpace=$(echo "$tableName" | sed 's/ /_/g')
    touch "${tableNameReplacedSpace}.metadata"
    touch "${tableNameReplacedSpace}.data"
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
            if [[ ! "$columnName" =~ ^[a-zA-Z][a-zA-Z0-9_] || ${#columnName} -gt 64 ]]
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
    touch "${tableName}.metadata"
    touch "${tableName}.data"
    echo "Table with name '$tableName' created successfully"
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
            if [[ ! "$columnName" =~ ^[a-zA-Z][a-zA-Z0-9_]  || ${#columnName} -gt 64 ]]
             then
                echo "Sorry... invalid column name. Try another name starting with a letter, number, or underscore."
            elif grep -q -w "$columnName" "${tableName}.metadata"
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

    echo -n "$columnNames" >> "${tableName}.metadata"
    echo >> "${tableName}.metadata"
    echo -n "$dataTypes" >> "${tableName}.metadata"
    echo >> "${tableName}.metadata"
    echo "$primaryKeys" >> "${tableName}.metadata"
fi



