#Prefix to define the name of resource groups, resources etc
#Max chaacter limit of the prefix is 7
prefix = "AVS"

#Region to deploy the AVS Private Cloud and associated components
region = "eastus2"  # Use proper Azure region format

subscription_id = "xxxx-xxxx-xxxx-xxxx"
tenant_id       = "xxxx-xxxx-xxxx-xxxx"
client_id       = "xxxx-xxxx-xxxx-xxxx"
client_secret   = "super-secret-password"

# Private Cloud
avs-sku               = "AV36P"
avs-management_host_count = 3
avs-network_cidr      = "10.0.0.0/22"

#AVS requires a /22 CIDR range, this must not overlap with other networks to be used with AVS
clusters = {
  cluster1 = {
    name        = "workload-cluster1"
    cluster_node_count  = 16
    sku         = "AV36P"
    network_cidr = "10.0.0.0/22"  # need to change
  }
  cluster2 = {
    name        = "workload-cluster2"
    cluster_node_count  = 8
    sku         = "AV64"
    network_cidr = "10.4.0.0/22"    # need to change
  }
}
hcx_key_names    = ["hcxsite1"]
nsg_name         = "avs-nsg"

#Virtual network address space and required subnets, can be any CIDR range
vnetaddressspace   = "10.1.0.0/24"  # Example VNET address space
gatewaysubnet      = "10.1.0.0/27"  # Example gateway subnet
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
