# create resoucre group
az group create --name fintrust_rg1 --location "East US"

# deploy template
az deployment group create \
  --resource-group fintrust_rg1 \
  --template-file main.bicep \
  --parameters firewallPrivateIP='10.0.100.4'
