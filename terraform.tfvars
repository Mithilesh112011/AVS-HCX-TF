#Prefix to define the name of resource groups, resources etc
#Max chaacter limit of the prefix is 7
prefix = "avs"


#Region to deploy the AVS Private Cloud and associated components
region = "eastus2" # Use proper Azure region format

subscription_id = "xxxx-xxxx-xxxx-xxxx"
tenant_id       = "xxxx-xxxx-xxxx-xxxx"
client_id       = "xxxx-xxxx-xxxx-xxxx"
client_secret   = "super-secret-password"

# Private Cloud
avs_config = {
  sku                   = "AV36P"
  management_host_count = 3
  network_cidr          = "10.0.0.0/22"
}

#AVS requires a /22 CIDR range, this must not overlap with other networks to be used with AVS
clusters = {
  av36p = {
    name               = "avs-cluster-dev-eastus2-av36p-001"
    cluster_node_count = 16
    sku                = "AV36P"
  }
  av64 = {
    name               = "avs-cluster-dev-eastus2-av64-001"
    cluster_node_count = 8
    sku                = "AV64"
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

# Tags
tags = {
  Environment = "Production"
  Terraform   = "true"
  Owner       = "CloudTeam"
}
