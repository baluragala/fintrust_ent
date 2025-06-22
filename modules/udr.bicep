param location string
param firewallIP string

resource routeTable 'Microsoft.Network/routeTables@2023-04-01' = {
  name: 'rt-web'
  location: location
  properties: {
    routes: [
      {
        name: 'RouteToFirewall'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: firewallIP
        }
      }
    ]
  }
}

output routeTableId string = routeTable.id
