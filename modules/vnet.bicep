param location string
param vnetName string
param nsgWebId string
param nsgAppId string
param nsgDbId string
param routeTableWebId string

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'WebSubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: { id: nsgWebId }
          routeTable: { id: routeTableWebId }
        }
      }
      {
        name: 'AppSubnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
          networkSecurityGroup: { id: nsgAppId }
        }
      }
      {
        name: 'DbSubnet'
        properties: {
          addressPrefix: '10.0.3.0/24'
          networkSecurityGroup: { id: nsgDbId }
        }
      }
    ]
  }
}
