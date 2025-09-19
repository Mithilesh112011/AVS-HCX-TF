module "avs_passwords" {
  source = "./modules/avs_passwords"
}

module "avs_privatecloud" {
  source                = "./modules/avs_privatecloud"
  region                = var.region
  env                   = var.env
  resource_group_name   = azurerm_resource_group.privatecloud.name
  sku_name              = var.avs_config.mgmt.sku
  management_host_count = var.avs_config.mgmt.mgmt_host_count
  network_cidr          = var.avs_config.mgmt.network_cidr
  nsxt_password         = module.avs_passwords.nsxt_password
  vcenter_password      = module.avs_passwords.vcenter_password
  tags                  = merge(var.mandatory_tags, {
    "Created_By" = "Ahead"
  })
}

module "avs_workload_clusters_av36p" {
  source             = "./modules/avs_workload_clusters"
  privatecloud_id    = module.avs_privatecloud.privatecloud_id
  cluster_name       = var.clusters.av36p["name"]
  cluster_node_count = var.clusters.av36p["host_count"]
  sku_name           = var.clusters.av36p["sku"]
}

module "avs_workload_clusters_av64" {
  source             = "./modules/avs_workload_clusters"
  privatecloud_id    = module.avs_privatecloud.privatecloud_id
  cluster_name       = var.clusters.av64.name
  cluster_node_count = var.clusters.av64.host_count
  sku_name           = var.clusters.av64.sku
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
  privatecloud_id = module.avs_privatecloud.privatecloud_id
}

module "avs_lock" {
  for_each        = var.clusters
  source          = "./modules/avs_lock"
  prefix          = var.prefix
  privatecloud_id = module.avs_privatecloud.privatecloud_id
}

module "avs_hcx" {
  source          = "./modules/avs_hcx"
  privatecloud_id = module.avs_privatecloud.privatecloud_id
  hcx_wait_time   = "120s"
  hcx_key_names   = var.hcx_key_names
  environment     = "Production"
}