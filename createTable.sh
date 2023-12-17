#!/usr/bin/bash

echo "========================================================="
echo  -e "Hello And Welcome To H&N Database Administration System.\nLet's Start To Create Table"
echo "========================================================="


#___________________________________________________________________________________________________________________________
#as i want to loop all over until i find correct choice i used flag instead of using break 
#here we validate the name of the table if its wrong at all
flag=false
while [ "$flag" != true ]
do
    read -p "Please enter a table name to create: " tableName
    if [ -e "${tableName}.metadata" ]
    then
        echo "Sorry... table with name '$tableName' already exists. Try another name."
    elif [[ ! "$tableName" =~ ^[a-zA-Z][a-zA-Z0-9_] ]]
     then
        echo "Sorry... invalid name. Try another name starting with a letter, number, or underscore and BE CAREFUL to be less than 64 character "
    else
        flag=true
    fi
done
#_________________________________________________________________________________________________________________________________
#here we validate the name if it have spaces replace it with underscore using sed
if echo "$tableName" | grep -q ' ' 
then
    tableNameReplacedSpace=$(echo "$tableName" | sed 's/ /_/g')
    touch "${tableNameReplacedSpace}.metadata"
    touch "${tableNameReplacedSpace}.data"
    echo "Table with name '$tableNameReplacedSpace' created successfully"

    # Validate and get a valid fieldNumber
    validFieldNumber=false
    while [ "$validFieldNumber" != true ]
    do
        read -p "Please enter the number of fields you want to enter: " fieldNumber
        # Check if fieldNumber is a valid number
        if [[ "$fieldNumber" =~ ^[0-9]+$ ]]
        then
            validFieldNumber=true
        else
            echo "Invalid input. Please enter a valid number for the field number."
        fi
    done

    fieldNames=""
    dataTypes=""
    primaryKeys=""
    for ((i=1; i<=fieldNumber; i++))
    do
        flag=false
        while [ "$flag" != true ]
        do
            read -p "Please enter field name for field $i: " fieldName
            if [[ ! "$fieldName" =~ ^[a-zA-Z][a-zA-Z0-9_] || ${#fieldName} -gt 64 ]]
            then
                echo "Sorry... invalid field name. Try another name starting with a letter, number, or underscore."
            elif grep -q -w "$fieldName" "${tableNameReplacedSpace}.metadata"
            then
                echo "Sorry... field name '$fieldName' already exists. Try another name."
            else
                fieldNames+="$fieldName:"
                while [ "$flag" != true ]
                do
                    read -p "Please enter field data type for $fieldName you have to write ( 'string' or 'number') : " fieldDataType
                    case "$fieldDataType" in
                        "string" | "number")
                            dataTypes+="$fieldDataType:"
                            flag=true
                            ;;
                        *)
                            echo "Invalid data type. Please enter ( 'string' or 'number')."
                            ;;
                    esac
                done

                flag=false
                while [ "$flag" != true ]
                do
                    read -p "Is $fieldName a primary key? (yes/no): " isPrimary
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

    echo -n "$fieldNames" >> "${tableNameReplacedSpace}.metadata"
    echo >> "${tableNameReplacedSpace}.metadata"
    echo -n "$dataTypes" >> "${tableNameReplacedSpace}.metadata"
    echo >> "${tableNameReplacedSpace}.metadata"
    echo "$primaryKeys" >> "${tableNameReplacedSpace}.metadata"



#___________________________________________________________________________________________________________________________________
#if user enter table name without any problems
else
    touch "${tableName}.metadata"
    touch "${tableName}.data"
    echo "Table with name '$tableName' created successfully"
    validFieldNumber=false
    while [ "$validFieldNumber" != true ]
    do
        read -p "Please enter the number of fields you want to enter: " fieldNumber
        # Check if fieldNumber is a valid number
        if [[ "$fieldNumber" =~ ^[0-9]+$ ]]
        then
            validFieldNumber=true
        else
            echo "Invalid input. Please enter a valid number for the field number."
        fi
    done
    fieldNames=""
    dataTypes=""
    primaryKeys=""
for ((i=1; i<=fieldNumber; i++))
do
    counter=0
    flag=false
    pkFlag=false
    while [ "$flag" != "true" ]
    do
        read -p "Please enter field name for field $i: " fieldName
        if [[ ! "$fieldName" =~ ^[a-zA-Z][a-zA-Z0-9_]  || ${#fieldName} -gt 64 ]]
         then
            echo "Sorry... invalid field name. Try another name starting with a letter, number, or underscore."
        elif grep -q -w "$fieldName" "${tableName}.metadata"
        then
            echo "Sorry... field name '$fieldName' already exists. Try another name."
        else
            fieldNames+="$fieldName:"
            while [ "$flag" != "true" ]
            do
                read -p "Please enter field data type for $fieldName you have to write ( 'string' or 'number') : " fieldDataType
                case "$fieldDataType" in
                    "string" | "number")
                        dataTypes+="$fieldDataType:"
                        flag=true
                        ;;
                    *)
                        echo "Invalid data type. Please enter ('string' or 'number')."
                        ;;
                esac
            done

            while [ "$pkFlag" != "true" ]
            do
                read -p "Is $fieldName a primary key? (yes/no): " isPrimary
                case "$isPrimary" in
                    "yes" )
                        if [[ $counter -eq 0 && ! $(grep -o -w "yes" <<< "$primaryKeys") ]]
                        then
                            primaryKeys+="$isPrimary:"
                       	    echo ${primaryKeys[@]}
                            counter=$((counter + 1))
                            pkFlag=true
                        else
                            echo "Sorry... can't add more than one unique PK in the same table"
                            pkFlag=false
                        fi
                        ;;
                    "no")
                        primaryKeys+="$isPrimary:"
                        pkFlag=true
                        ;;
                    *)
                        echo "Invalid input. Please enter 'yes' or 'no'."
                        ;;
                esac
            done
       fi
    done
done
    echo -n "$fieldNames" >> "${tableName}.metadata"
    echo >> "${tableName}.metadata"
    echo -n "$dataTypes" >> "${tableName}.metadata"
    echo >> "${tableName}.metadata"
    echo "$primaryKeys" >> "${tableName}.metadata"
fi



