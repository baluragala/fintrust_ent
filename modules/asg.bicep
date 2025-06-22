param location string

resource asgWeb 'Microsoft.Network/applicationSecurityGroups@2023-04-01' = {
  name: 'asg-web1'
  location: location
}

resource asgApp 'Microsoft.Network/applicationSecurityGroups@2023-04-01' = {
  name: 'asg-app1'
  location: location
}

resource asgDb 'Microsoft.Network/applicationSecurityGroups@2023-04-01' = {
  name: 'asg-db1'
  location: location
}

output asgWebId string = asgWeb.id
output asgAppId string = asgApp.id
output asgDbId string = asgDb.id
