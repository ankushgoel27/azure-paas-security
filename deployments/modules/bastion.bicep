param prefix string
param subnetId string

resource bastionIP 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: '${prefix}-bastion-ip'
  location: resourceGroup().location
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2020-06-01' = {
  name: '${prefix}-bastion'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'bastionConf'
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: bastionIP.id
          }
        }
      }
    ]
  }
}