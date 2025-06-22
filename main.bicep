param location string = resourceGroup().location
param vnetName string = 'fintrust-vnet'
param firewallPrivateIP string

// Deploy ASGs
module asgs 'modules/asg.bicep' = {
  name: 'asgDeployment'
  params: {
    location: location
  }
}

// Deploy NSGs with ASG references
module nsgs 'modules/nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    location: location
    asgWebId: asgs.outputs.asgWebId
    asgAppId: asgs.outputs.asgAppId
    asgDbId: asgs.outputs.asgDbId
  }
}

// Deploy UDR for WebSubnet
module udr 'modules/udr.bicep' = {
  name: 'udrDeployment'
  params: {
    location: location
    firewallIP: firewallPrivateIP
  }
}

// Deploy VNet and Subnets with NSGs and UDR
module vnet 'modules/vnet.bicep' = {
  name: 'vnetDeployment'
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
  name: 'vmDeployment'
  params: {
    location: location
    vnetName: vnetName
    asgWebId: asgs.outputs.asgWebId
    asgAppId: asgs.outputs.asgAppId
    asgDbId: asgs.outputs.asgDbId
  }
}
