#!/bin/bash

#./enforce_branch.sh $GITHUB_TOKEN $REPO_NAME 
# ./enforce_branch.sh $GH_TOKEN $REPO_NAME 

# Define las variables para la autenticación y el repositorio
GITHUB_TOKEN=$1
REPO_OWNER="NBN23dev"
REPO_NAME=$2

####### modificar develop pa q nbn23 pueda subir sin hacer pr

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

for BRANCH_NAME in "master"; do
    # Realiza la solicitud PUT a la API de GitHub para actualizar las reglas de protección de la rama
    curl -X PUT "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/branches/$BRANCH_NAME/protection" \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.luke-cage-preview+json" \
    -H "Content-Type: application/json" \
    -d "$DATA"
done

#curl -u cris-sp:$GITHUB_TOKEN -X GET https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/refs/heads/develop
# meter el codeowners tb 

#curl -u cris-sp:$GITHUB_TOKEN -X POST -d '{"ref": "refs/heads/release"}' https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/git/refs
