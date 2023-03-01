#!/bin/bash

RESOURCE_GROUP_NAME=rg-kv
KEY_VAULT_NAME=kv-demo-089
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create key vault
az keyvault create --name $KEY_VAULT_NAME --resource-group $RESOURCE_GROUP_NAME --location eastus


