#!/bin/bash

#./gcr.sh #GITHUB_TOKEN #USER
REPO_OWNER="nbn23dev"
GITHUB_TOKEN=$1
USER=$2
archivo="./repos/gcr.txt"

if [ ! -f "$archivo" ]; then
    echo "El archivo $archivo no existe."
    exit 1
fi



while IFS= read -r line; 
# do ./create_release.sh "$GITHUB_TOKEN""$LINEA""$USER"
do 

    ./create_release.sh $GITHUB_TOKEN $line $USER
    
done < "$archivo"