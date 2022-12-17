#How to set up IaC for Azure using CLI


1. [Install Azure Cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

2. Login to Azure 

```sh
az login
```

3. take the "id" of the azure account you want to use
```sh
az account show
```
4. Set your subscription
```sh
account set --subscription <id of azure account>
```
5. 

```sh
az deployment group create --resource-group <name of resource group> --template-file <path of file>
```
6. Naming Convention

'dev' pipeline

"parameters": {
        "appServiceAppName": {
            "value": "vprohaska-assignment-FE-app"
        },
        "appServicePlanName": {
            "value": "vprohaska-assignment-dev-serviceplan"
        },
        "storageAccountName": {
            "value": "vprohaska-assignment-dev-storage"
        }
        

'prod' pipeline

"parameters": {
        "appServiceAppName": {
            "value": "vprohaska-assignment-prod-app"
        },
        "appServicePlanName": {
            "value": "vprohaska-assignment-prod-serviceplan"
        },
        "storageAccountName": {
            "value": "vprohaska-assignment-prod-storage"
        }
        
Secrets:

DBUSER: database host user
DBHOST: database host server
DBPASS: password
DBNAME: database name for development

__________________

DBNAME: databasename for production



##Done!