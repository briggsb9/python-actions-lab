param webAppName string = uniqueString('YOURNAME') // Generate unique String for web app name
param sku string = 'S1' // The SKU of App Service Plan
param linuxFxVersion string = 'PYTHON|3.9' // The runtime stack of web app
param location string = resourceGroup().location // Location for all resources

var appServicePlanName = toLower('asp-${webAppName}')
var webSiteName = toLower('wapp-${webAppName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}

output hostname string = appService.name
