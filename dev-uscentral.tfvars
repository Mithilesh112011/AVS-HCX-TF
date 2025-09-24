prefix = "avs"
env = "dev"
region = "centralus"
subscription_id = "9dc2d2fe-5b8d-4e24-8ae8-cc15271e5a27"
client_secret   = "super-secret-password"
avs_config = {
  mgmt = {
    sku                   = "av36p"
    mgmt_host_count       = "3"
    network_cidr          = "10.0.0.0/22"
  }
}
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