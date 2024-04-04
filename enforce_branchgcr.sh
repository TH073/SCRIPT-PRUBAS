#!/bin/bash
#./enforce_branchgcr.sh 

REPO_OWNER="NBN23dev"
GITHUB_TOKEN=$1
archivo="./repos/gcr.txt"
BRANCH_NAME=$2
#Checkear si el archivo (este contiene los repositorios en los que queremos realizar cambios) existe.
if [ ! -f "$archivo" ]; then
    echo "El archivo $archivo no existe."
    exit 1
fi

# Define el cuerpo de la solicitud con las reglas de protección actualizadas
DATA=$(cat <<EOF
{
  "required_status_checks": {
    "strict": true,
    "contexts": []
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "required_approving_review_count": 1,
    "bypass_pull_request_allowances": {
      "users": ["nbn23-terraform"]
    } 
  },
  "restrictions": null,
  "required_conversation_resolution": true,
  "lock_branch": false,
  "allow_fork_syncing": true
}
EOF
)

#Bucle para aplicar las protecciones a todos los repositorios con gcr.

while IFS= read -r line;
    do
    
        curl -X PUT "https://api.github.com/repos/$REPO_OWNER/${line%?}/branches/$BRANCH_NAME/protection" \
            -H "Authorization: token $GITHUB_TOKEN" \
            -H "Accept: application/vnd.github.luke-cage-preview+json" \
            -H "Content-Type: application/json" \
            -d "$DATA" 
    done < "$archivo"