@sys.description('The Web App name.')
@minLength(3)
@maxLength(24)
param appServiceAppName string 
@sys.description('The App Service Plan name.')
@minLength(3)
@maxLength(24)
param appServicePlanName string 
@sys.description('The Storage Account name.')
@minLength(3)
@maxLength(24)
param storageAccountName string
@allowed([
  'nonprod'
  'prod'
  ])
param environmentType string = 'nonprod'
param location string = resourceGroup().location
param names array = [ 'FE', 'BE' ]
@secure()
param dbhost string
@secure()
param dbuser string
@secure()
param dbpass string
@secure()
param dbname string


var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'  

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
    name: storageAccountName
    location: location
    sku: {
      name: storageAccountSkuName
    }
    kind: 'StorageV2'
    properties: {
      accessTier: 'Hot'
    }
  }

  module appService 'modules/appModule.bicep' = [ for name in names: {
    name: 'appService + ${name}'
    params: {
      location: location
      appServiceAppName:'${appServiceAppName} + ${name}'
      appServicePlanName: appServicePlanName
      environmentType: environmentType
      dbhost: dbhost
      dbuser: dbuser
      dbpass: dbpass
      dbname: dbname
    }
  }]

 // output using loop

  output appServiceAppHostName array = [ for name in names: {
    name: 'appService + ${name}'
    value: appService[name].outputs.appServiceAppHostName
  }]
