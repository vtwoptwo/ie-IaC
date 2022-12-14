resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: 'vprohaska-storage'
  location: 'westus3'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
