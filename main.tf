module "avs_passwords" {
  source = "./modules/avs_passwords"
}

module "avs_privatecloud" {
  source              = "./modules/avs_privatecloud"
  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.privatecloud.name
  location            = var.region
  sku_name            = var.avs-sku
  management_host_count= var.avs-management_host_count
  network_cidr        = var.avs-network_cidr
  nsxt_password       = module.avs_passwords.nsxt_password
  vcenter_password    = module.avs_passwords.vcenter_password
  tags = {
    Environment = "Production"
    Service     = "AVS-SDDC"
    Terraform   = "true"
    Creator     = "Terraform"
  }
}

module "avs_workload_clusters1" {
  source            = "./modules/avs_workload_clusters1"
  privatecloud_id   = module.avs_privatecloud.privatecloud_id
  cluster_name      = "Workload-Cluster-1"
  cluster_node_count = 16  # Minimum 3 nodes required for AVS
  sku_name          = "AV36P"  # Standard AVS SKU
}

module "avs_workload_clusters2" {
  source            = "./modules/avs_workload_clusters2"
  privatecloud_id   = module.avs_privatecloud.privatecloud_id
  cluster_name      = "Workload-Cluster-2"
  cluster_node_count = 8  # Minimum 3 nodes required for AVS
  sku_name          = "AV64"  # Standard AVS SKU
}

/*

# Use cluster outputs from privatecloud module
module "avs_workload_clusters1" {
  source            = "./modules/avs_workload_clusters1"
  privatecloud_id   = module.privatecloud["cluster1"].privatecloud_id
  cluster_name      = var.clusters["cluster1"].name
  cluster_node_count = var.clusters["cluster1"].host_count
  sku_name          = var.clusters["cluster1"].sku
}

module "avs_workload_clusters2" {
  source            = "./modules/avs_workload_clusters2"
  privatecloud_id   = module.privatecloud["cluster2"].privatecloud_id
  cluster_name      = var.clusters["cluster2"].name
  cluster_node_count = var.clusters["cluster2"].host_count
  sku_name          = var.clusters["cluster2"].sku
}
# */

module "avs_networking" {
  for_each        = var.clusters
  source          = "./modules/avs_networking"
  prefix          = var.prefix
  privatecloud_id = module.avs_privatecloud[each.key].privatecloud_id
}

module "avs_lock" {
  for_each        = var.clusters
  source          = "./modules/avs_lock"
  prefix          = var.prefix
  privatecloud_id = module.avs_privatecloud[each.key].privatecloud_id
}

module "avs_hcx" {
  source          = "./modules/avs_hcx"
  privatecloud_id = module.avs_privatecloud.privatecloud_id
  hcx_wait_time   = "120s"
  hcx_key_names   = var.hcx_key_names
  environment     = "Production"
}