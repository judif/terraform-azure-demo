#!/bin/bash

# Create the SP
az ad app create --display-name terraform-azure-rw-identity
APPLICATION_ID=$(az ad app list --all --query "[?displayName=='terraform-azure-rw-identity'].appId" --output tsv)
az ad sp create --id $APPLICATION_ID

# Assign roles to the SP
az role assignment create --assignee $APPLICATION_ID --role "Contributor"
az role assignment create --assignee $APPLICATION_ID --role "Reader and Data Access"

# Create the only OIDC credentials for that SP (for GitHub Actions "production" environment)
# Be sure to replace <ORGANIZATION> and <REPOSITORY> with your GitHub organization and repository name
cat <<EOF > oidc.json
{
    "audiences": [
    "api://AzureADTokenExchange"
    ],
    "description": "",
    "issuer": "https://token.actions.githubusercontent.com",
    "name": "production-env-oidc",
    "subject": "repo:judif/terraform-azure-demo:environment:production"
}
EOF
az ad app federated-credential create --id $APPLICATION_ID --parameters oidc.json