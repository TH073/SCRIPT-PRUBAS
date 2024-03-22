#!/bin/bash

REPO_OWNER="nbn23dev"
GITHUB_TOKEN=$1
archivo="./repos/gcr.txt"
BRANCH=$2

#Checkear si el archivo (este contiene los repositorios en los que queremos realizar cambios) existe.
if [ ! -f "$archivo" ]; then
    echo "El archivo $archivo no existe."
    exit 1
fi

#Bucle para subir desproteger todos los repositorios GCR.

while IFS= read -r line;
    do 
        curl -L \
            -X DELETE \
            -H "Accept: application/vnd.github+json" \
             -H "Authorization: Bearer $GITHUB_TOKEN " \
             -H "X-GitHub-Api-Version: 2022-11-28" \
            https://api.github.com/repos/$REPO_OWNER/${line%?}/branches/$BRANCH/protection/enforce_admins
    done < "$archivo"
