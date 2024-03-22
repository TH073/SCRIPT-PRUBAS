#!/bin/bash

#check_gcr.sh $repository

input_file="repos/rest.json"
# Leer la lista de repositorios desde el archivo
while IFS= read -r repository; do
    echo "Verificando Dockerfile en el repositorio: $repository"

    # Hacer una solicitud a la API de GitHub para obtener la información del repositorio
    response=$(curl -s -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $1" "https://api.github.com/repos/NBN23dev/$repository/contents" | jq -r '.[].name')

    # Verificar si el repositorio tiene un archivo Dockerfile
    if echo "$response" | grep -q '^Dockerfile$'; then
         echo $repository >> repos/gcr.json
    else
        echo $repository >> repos/tools_rest.json
    fi

    echo "--------------------------------------------"

done < "$input_file"

rm $input_file