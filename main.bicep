param location string = resourceGroup().location
param vnetName string = 'fintrust-vnet1'
param firewallPrivateIP string

// Deploy ASGs
module asgs 'modules/asg.bicep' = {
  name: 'asgDeployment1'
  params: {
    location: location
  }
}

// Deploy NSGs with ASG references
module nsgs 'modules/nsg.bicep' = {
  name: 'nsgDeployment1'
  params: {
    location: location
    asgWebId: asgs.outputs.asgWebId
    asgAppId: asgs.outputs.asgAppId
    asgDbId: asgs.outputs.asgDbId
  }
}

// Deploy UDR for WebSubnet
module udr 'modules/udr.bicep' = {
  name: 'udrDeployment1'
  params: {
    location: location
    firewallIP: firewallPrivateIP
  }
}

// Deploy VNet and Subnets with NSGs and UDR
module vnet 'modules/vnet.bicep' = {
  name: 'vnetDeployment1'
  params: {
    location: location
    vnetName: vnetName
    nsgWebId: nsgs.outputs.nsgWebId
    nsgAppId: nsgs.outputs.nsgAppId
    nsgDbId: nsgs.outputs.nsgDbId
    routeTableWebId: udr.outputs.routeTableId
  }
}


// Deploy VMs into subnets
module vms 'modules/vm.bicep' = {
  name: 'vmDeployment1'
  params: {
    location: location
    vnetName: vnetName
    asgWebId: asgs.outputs.asgWebId
    asgAppId: asgs.outputs.asgAppId
    asgDbId: asgs.outputs.asgDbId
  }
}
