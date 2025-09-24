module "avs_privatecloud" {
  source                = "./modules/avs_privatecloud"
  region                = var.region
  env                   = var.env
  prefix          = var.prefix
  resource_group_name   = azurerm_resource_group.privatecloud.name
  sku_name              = var.avs_config.mgmt.sku
  management_host_count = var.avs_config.mgmt.mgmt_host_count
  network_cidr          = var.avs_config.mgmt.network_cidr
  tags                  = merge(var.mandatory_tags, {
    "Created_By" = "Ahead"
  })
  hcx_wait_time   = "120s"
  hcx_key_names   = var.hcx_key_names
  environment     = "Production"
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