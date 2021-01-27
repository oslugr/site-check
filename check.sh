#!/bin/bash

WEBS=( "" )
MAIL=""

for i in "${WEBS[@]}"
do

    SALIDA=`wget -O- $i 2>&1`

    if [ $? -eq 0 ]; then
        echo "$i - OK"
    else
        echo "$i - MAL"
        echo -e "Subject: $i se ha caído\n\n Mensaje de log:\n\n$SALIDA" | sendmail -v $MAIL
    fi 

done