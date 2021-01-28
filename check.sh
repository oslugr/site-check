#!/bin/bash

WEBS=( "" ) # Webs a comprobar
MAIL=( "" ) # Emails donde enviar el correo
ARCHIVO=""  # Archivo donde se guardan las webs que no funcionan pero ya se han notificado

touch $ARCHIVO

for i in "${WEBS[@]}"
do
    # Petición web
    SALIDA=`wget -O- $i 2>&1`

    if [ $? -eq 0 ]; then
        echo "$i - OK"
        # La elimina del archivo al comprobar de nuevo que funciona
        sed -i "/$i/d" $ARCHIVO
    else
        # Comprueba si ya ha notificado que la web no funciona
        grep $i $ARCHIVO > /dev/null

        if [ $? -eq 0 ]; then
            echo "$i - Mal pero ya se ha notificado"
        else
            echo "$i - MAL"
            printf "$i\n" > $ARCHIVO

            for j in "${MAIL[@]}"
            do
                echo -e "Subject: $i se ha caído\n\n Mensaje de log:\n\n$SALIDA" | sendmail -v $j
            done
        fi
    fi 

done