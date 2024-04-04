#!/bin/bash

# ./check_branch.sh $GH_TOKEN $REPO_NAME $BRANCH

# Define las variables para la autenticación y el repositorio

GITHUB_TOKEN=$1
REPO_OWNER="TH073"
archivo="./repos/prueba_repositorios.txt"

# Realiza la solicitud GET a la API de GitHub para obtener las reglas de protección de la rama

while = read -r line 
    do
        curl -X GET -H "Authorization: token $GITHUB_TOKEN" \
        "https://api.github.com/repos/$REPO_OWNER/${line%?}/branches/$develop/protection"

    done < "$archivo"   

