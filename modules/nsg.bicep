param location string
param asgWebId string
param asgAppId string
param asgDbId string

resource nsgWeb 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'nsg-web'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowAppToWeb'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceApplicationSecurityGroups: [{ id: asgAppId }]
          destinationApplicationSecurityGroups: [{ id: asgWebId }]
        }
      }
      {
        name: 'AllowSSH'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource nsgApp 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'nsg-app'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowWebToApp'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceApplicationSecurityGroups: [{ id: asgWebId }]
          destinationApplicationSecurityGroups: [{ id: asgAppId }]
        }
      }
      {
        name: 'AllowAppToDbOutbound'
        properties: {
          priority: 110
          direction: 'Outbound'
          access: 'Allow'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceApplicationSecurityGroups: [{ id: asgAppId }]
          destinationApplicationSecurityGroups: [{ id: asgDbId }]
        }
      }
      {
        name: 'AllowSSH'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource nsgDb 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'nsg-db'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowAppToDb'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceApplicationSecurityGroups: [{ id: asgAppId }]
          destinationApplicationSecurityGroups: [{ id: asgDbId }]
        }
      }
      {
        name: 'AllowSSH'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

output nsgWebId string = nsgWeb.id
output nsgAppId string = nsgApp.id
output nsgDbId string = nsgDb.id
