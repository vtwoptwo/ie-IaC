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

##Done!