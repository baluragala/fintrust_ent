# create resoucre group
az group create --name fintrust_rg --location "East US"

# deploy template
az deployment group create \
  --resource-group fintrust_rg \
  --template-file main.bicep \
  --parameters firewallPrivateIP='10.0.100.4'
