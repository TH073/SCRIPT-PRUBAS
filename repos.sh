#!/bin/bash

#./repos.sh $TOKEN 


# ./repos $TOKEN

TOKEN=$1

# Realiza la solicitud a la API de GitHub
response1=$(curl -s -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/orgs/nbn23dev/repos?type=all&sort=full_name&page=1&per_page=200")
response2=$(curl -s -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/orgs/nbn23dev/repos?type=all&sort=full_name&page=2&per_page=100")

# Verifica si la solicitud fue exitosa
if [ $? -eq 0 ]; then
   # Extrae los nombres de los repositorios e imprímelos
     echo "Repositorios en la organización:"
     echo "$response1" | jq -r '.[].name' > repos.json
     echo "$response2" | jq -r '.[].name' >> repos.json
 else
     echo "Error al obtener repositorios."
 fi

# core-graphql-xxxxxx ----> Servicio de graphql (lectura)
# xxxxxx-sync -----> servicio de graphql (escritura)
# gcf-xxxxxx -----> Cloud function (lectura y escritura normalmente)

# Devops Repos
cat repos.json | grep 'terraform' > repos/devops.json
cat repos.json | grep 'cicd' >> repos/devops.json

# CFs Repos
cat repos.json | grep ^gcf > repos/cf.json

# CRs Rest Repos
cat repos.json | grep ^gcr > repos/gcr.txt

# GraphQl Repos
cat repos.json | grep 'core-graphql-.*' > repos/graphql.json
cat repos.json | grep '.*-sync$' >> repos/graphql.json

# Certificates 
cat repos.json | grep 'certificates' > repos/certificates.json

# Frontend
cat repos.json | grep '.*-app$' > repos/frontend.json
cat repos.json | grep 'widget' >> repos/frontend.json

# Libs 
cat repos.json | grep '^graphql' > repos/libs.json
cat repos.json | grep 'cloud-tasks' >> repos/libs.json

# Rest Repos
cat repos.json | grep -v '^graphql' | grep -v 'cloud-tasks' | grep -v '^gcf'| grep -v '^gcr'| grep -v '.*-sync' | grep -v 'core-graphql-.*' | grep -v 'terraform' | grep -v 'cicd' | grep -v 'certificates' | grep -v '.*-app$' | grep -v 'widget' > repos/rest.json 
