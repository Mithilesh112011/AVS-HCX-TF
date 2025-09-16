resource "azurerm_vmware_cluster" "cluster1" {
  name               = var.cluster_name
  vmware_cloud_id    = var.privatecloud_id
  cluster_node_count = var.cluster_node_count
  sku_name           = var.sku_name
}

