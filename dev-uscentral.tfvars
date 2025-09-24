#Prefix to define the name of resource groups, resources etc
#Max chaacter limit of the prefix is 7
prefix = "avs"
env = "dev"

#Region to deploy the AVS Private Cloud and associated components
region = "centralus" # Use proper Azure region format

subscription_id = "9dc2d2fe-5b8d-4e24-8ae8-cc15271e5a27"
client_secret   = "super-secret-password"

# Private Cloud
avs_config = {
  mgmt = {
    sku                   = "av36p"
    mgmt_host_count       = "3"
    network_cidr          = "10.0.0.0/22"
  }
}


#AVS requires a /22 CIDR range, this must not overlap with other networks to be used with AVS
clusters = {
  av36p = {
    name               = "avs-cluster-dev-eastus2-av36p-001"
    host_count = 16
    sku                = "av36p"
  }
  av64 = {
    name               = "avs-cluster-dev-eastus2-av64-001"
    host_count = 8
    sku                = "av64"
  }
}
hcx_key_names = ["hcxsite1"]
nsg_name      = "avs-nsg"

#Virtual network address space and required subnets, can be any CIDR range
vnetaddressspace = "10.1.0.0/24" # Example VNET address space
gatewaysubnet    = "10.1.0.0/27" # Example gateway subnet
# azurebastionsubnet = "10.1.0.64/26"
# jumpboxsubnet      = "10.1.0.128/25"

#Enable or Disable telemetry
telemetry_enabled = true