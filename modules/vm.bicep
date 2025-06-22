param location string
param vnetName string
param asgWebId string
param asgAppId string
param asgDbId string

var subnetWebId = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'WebSubnet1')
var subnetAppId = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'AppSubnet1')
var subnetDbId  = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'DbSubnet1')

module vmWeb 'vmInstance.bicep' = {
  name: 'webVM1'
  params: {
    vmName: 'vm-web1'
    subnetId: subnetWebId
    asgId: asgWebId
    location: location
  }
}

module vmApp 'vmInstance.bicep' = {
  name: 'appVM1'
  params: {
    vmName: 'vm-app1'
    subnetId: subnetAppId
    asgId: asgAppId
    location: location
  }
}

module vmDb 'vmInstance.bicep' = {
  name: 'dbVM1'
  params: {
    vmName: 'vm-db1'
    subnetId: subnetDbId
    asgId: asgDbId
    location: location
  }
}

