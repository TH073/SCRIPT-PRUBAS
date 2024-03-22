#!/bin/bash
REPO_OWNER="nbn23dev"
GITHUB_TOKEN=$1
BRANCHNAME=$2
archivo="gcr.txt"

if [ ! -f "$archivo" ]; then
    echo "El archivo $archivo no existe."
    exit 1
fi

while IFS= read -r linea && [ -n "$linea" ];
 do ./check_branch.sh "$GITHUB_TOKEN" "$REPO_OWNER""$LINEA" "$BRANCHNAME"
done < "$archivo"  

if [ $? -eq 0 ]; then
    echo "PROTECTED"; 
    do  "$REPO_OWNER""$LINEA""$BRANCH_NAME""$GITHUB_TOKEN"
else
    echo "NOT-PROTECTED"
fi