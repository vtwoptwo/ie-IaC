# How to set up IaC for Azure 


### IaC using Azure CLI

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

### IaC using GitHub Actions

1. Naming Convention in the file to configure different environments and respective deployment names of the resources

'dev' pipeline
```sh
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
``` 

'prod' pipeline
```sh
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
```



2.Note that I used a loop in the main.bicep folder, in order to create to App Services at once, with DEV or PROD nomenclature respectively.

```sh
 module appService 'modules/appModule.bicep' = [  for i in range(0,2): {
    name: 'appService${names[i]}'
    params: {
      location: location
      appServiceAppName:'${appServiceAppName}${names[i]}'
      appServicePlanName: appServicePlanName
      environmentType: environmentType
      dbhost: dbhost
      dbuser: dbuser
      dbpass: dbpass
      dbname: dbname
    }
  }]

 // output using loop

  output appServiceAppHostName array = [ for i in range(0,2): {
    name: 'appService${names[i]}'
    value: appService[i].outputs.appServiceAppHostName
  }]
 
```

3. Configuring the Secrets per pipeline
 <table align="center" >
  <tr>
    <th>----</th>
    <th>DBUSER</th>
    <th>DBHOST</th>
    <th>DBPASS</th>
    <th>DBNAME</th>
    <th>AZURE_CREDENTIALS</th>
    
  </tr>
  <tr>  
    <td>Secret Type </td>
    <td>Environtment Secret for development/production respectively</td>
    <td>Environtment Secret for development/production respectively</td>
    <td>Environment Secret for development/production respectively</td>
    <td>Environment Secret for development/production respectively</td>
    <td>Repository Secret</td>
    </tr>

  <tr>  
    <td>Decription </td>
    <td>database host user</td>
    <td>database host server</td>
    <td>password for the db server</td>
    <td>database name </td>
    <td href = "#Credentials">azure credentials json</td>
</tr>
</tr>
</table>



### Credentials 

Make sure to set up your azure credentials
```sh
{

  "clientId": ,

  "clientSecret": ,

  "subscriptionId": ,

  "tenantId": ,

  "activeDirectoryEndpointUrl": ,

  "resourceManagerEndpointUrl": ,

  "activeDirectoryGraphResourceId":,

  "sqlManagementEndpointUrl": ,

  "galleryEndpointUrl": ,

  "managementEndpointUrl": 

}
```


