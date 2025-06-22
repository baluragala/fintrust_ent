param location string
param vnetName string
param asgWebId string
param asgAppId string
param asgDbId string

var subnetWebId = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'WebSubnet')
var subnetAppId = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'AppSubnet')
var subnetDbId  = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'DbSubnet')

module vmWeb 'vmInstance.bicep' = {
  name: 'webVM'
  params: {
    vmName: 'vm-web'
    subnetId: subnetWebId
    asgId: asgWebId
    location: location
  }
}

module vmApp 'vmInstance.bicep' = {
  name: 'appVM'
  params: {
    vmName: 'vm-app'
    subnetId: subnetAppId
    asgId: asgAppId
    location: location
  }
}

module vmDb 'vmInstance.bicep' = {
  name: 'dbVM'
  params: {
    vmName: 'vm-db'
    subnetId: subnetDbId
    asgId: asgDbId
    location: location
  }
}

