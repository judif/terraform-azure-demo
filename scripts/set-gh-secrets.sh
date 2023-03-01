# Set repository default secrets
# Be sure to replace <AZURE_SUBSCRIPTION> with the name of your Azure subscription
AZURE_CLIENT_ID=$(az ad app list --all --query "[?displayName=='terraform-azure-ro-identity'].appId" --output tsv)
AZURE_TENANT_ID=$(az account list --all --query "[?name=='ME-MngEnvMCAP015399-jufreiberger-1'].tenantId" --output tsv)
AZURE_SUBSCRIPTION_ID=$(az account list --all --query "[?name=='ME-MngEnvMCAP015399-jufreiberger-1'].id" --output tsv)
gh secret set AZURE_CLIENT_ID --body "$AZURE_CLIENT_ID"
gh secret set AZURE_TENANT_ID --body "$AZURE_TENANT_ID"
gh secret set AZURE_SUBSCRIPTION_ID --body "$AZURE_SUBSCRIPTION_ID"

# Set secret for the production environment
AZURE_CLIENT_ID=$(az ad app list --all --query "[?displayName=='terraform-azure-rw-identity'].appId" --output tsv)
gh secret set AZURE_CLIENT_ID --body "$AZURE_CLIENT_ID" --env production


# Set storage key
