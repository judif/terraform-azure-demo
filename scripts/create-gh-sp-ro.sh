#!/bin/bash

# Create the SP
az ad app create --display-name terraform-azure-ro-identity
APPLICATION_ID=$(az ad app list --all --query "[?displayName=='terraform-azure-ro-identity'].appId" --output tsv)
az ad sp create --id $APPLICATION_ID

# Assign roles to the SP
az role assignment create --assignee $APPLICATION_ID --role "Reader"
az role assignment create --assignee $APPLICATION_ID --role "Reader and Data Access"

# Create the first OIDC credentials for that SP (for GitHub actions on pull requests)
# Be sure to replace <ORGANIZATION> and <REPOSITORY> with your GitHub organization and repository name
cat <<EOF > oidc.json
{
    "audiences": [
    "api://AzureADTokenExchange"
    ],
    "description": "Pull-Request OIDC for GHES Azure Terraform Reader app",
    "issuer": "https://token.actions.githubusercontent.com",
    "name": "pr-oidc",
    "subject": "repo:judif/terraform-azure-demo:pull_request"
}
EOF

az ad app federated-credential create --id $APPLICATION_ID --parameters oidc.json

# Create the second OIDC credentials for that SP (for GitHub actions on the main branch)
# Be sure to replace <ORGANIZATION> and <REPOSITORY> with your GitHub organization and repository name
cat <<EOF > oidc.json
{
    "audiences": [
    "api://AzureADTokenExchange"
    ],
    "description": "Main branch OIDC for GHES Azure Terraform Reader app",
    "issuer": "https://token.actions.githubusercontent.com",
    "name": "main-oidc",
    "subject": "repo:judif/terraform-azure-demo:ref:refs/heads/main"
}
EOF

az ad app federated-credential create --id $APPLICATION_ID --parameters oidc.json
