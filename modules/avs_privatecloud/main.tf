resource "azurerm_vmware_private_cloud" "privatecloud" {
  name                = "${var.prefix}-${var.env}-${var.region}-sddc"
  resource_group_name = var.resource_group_name
  location            = var.region
  sku_name            = lower(var.sku_name)

  management_cluster {
     size = var.management_host_count
  }


  network_subnet_cidr         = var.network_cidr
  internet_connection_enabled = false
  nsxt_password               = var.nsxt_password
  vcenter_password            = var.vcenter_password

  timeouts {
    create = "10h"
    update = "10h"
    delete = "3h"
    read   = "5m"
  }

  lifecycle {
    ignore_changes = [
      nsxt_password,
      vcenter_password
    ]
  }

  tags = var.tags
}

