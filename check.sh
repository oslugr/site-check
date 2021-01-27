#!/bin/bash

WEBS=( "" )
MAIL=""
ARCHIVO=""

for i in "${WEBS[@]}"
do

    SALIDA=`wget -O- $i 2>&1`

    if [ $? -eq 0 ]; then
        echo "$i - OK"
        sed -i "/$i/d" $ARCHIVO
    else
        grep $i $ARCHIVO > /dev/null
        if [ $? -eq 0 ]; then
            echo "$i - Mal pero ya se ha notificado"
        else
            echo "$i - MAL"
            printf "$i\n" > $ARCHIVO
            echo -e "Subject: $i se ha caído\n\n Mensaje de log:\n\n$SALIDA" | sendmail -v $MAIL
        fi
    fi 
        fi
    fi 

done