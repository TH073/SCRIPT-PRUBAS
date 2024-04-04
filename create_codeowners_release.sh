#!/bin/bash

#./create_codeowners_release.sh #GITHUB_TOKEN #branch

REPO_OWNER="NBN23dev"
GITHUB_TOKEN=$1
archivo="./repos/gcr.txt"
#Checkear si el archivo (este contiene los repositorios en los que queremos realizar cambios) existe.
if [ ! -f "$archivo" ]; then
    echo "El archivo $archivo no existe."
    exit 1
fi

#Bucle para subir CODEOWNERS a la rama release de todos los repositorios que comienzen con gcr.

while IFS= read -r line;
    do
    
       curl -L \
            -X PUT \
            -H "Accept: application/vnd.github+json" \
            -H "Authorization: Bearer $GITHUB_TOKEN" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
                "https://api.github.com/repos/$REPO_OWNER/${line%?}/contents/.github/CODEOWNERS" \
            -d '{"message":"codeowners","committer":{"name":"TH073","email":"adam.bouzi@nbn23.tech"},"content":"IyBDT0RFT1dORVJTIGZpbGUNCg0KKiBATkJOMjNkZXYvYXBwcm92ZXJzDQoNCi5naXRodWIvIEBOQk4yM2Rldi9kZXZvcHM=","branch":"develop"}'
              #he cambiado las comas simples por doble comas para meter el argumento $BRANCH 
    done < "$archivo"

#Lo que hace el archivo codeowners es, especificar quiénes son los propietarios (o responsables) de ciertas partes del código dentro del proyecto.
#Ademas , Cuando alguien crea una solicitud de extracción (pull request) que modifica archivos que están especificados en el archivo CODEOWNERS,
#los propietarios designados son notificados automáticamente para que revisen los cambios y tomen las acciones necesarias. 