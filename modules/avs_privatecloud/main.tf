terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
      version = ">=2.0.0"
    }
  }
}

resource "random_password" "nsxt" {
  length           = 14
  special          = true
  numeric          = true
  override_special = "%@#"
  min_special      = 1
  min_numeric      = 1
  min_upper        = 1
  min_lower        = 1
}

resource "random_password" "vcenter" {
  length           = 14
  special          = true
  numeric          = true
  override_special = "%@#"
  min_special      = 1
  min_numeric      = 1
  min_upper        = 1
  min_lower        = 1
}

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
  nsxt_password               = random_password.nsxt.result
  vcenter_password            = random_password.vcenter.result

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

resource "azurerm_vmware_express_route_authorization" "expressrouteauthkey" {
  name             = "${var.prefix}-AVS"
  private_cloud_id = azurerm_vmware_private_cloud.privatecloud.id
}

resource "azapi_resource" "hcx_addon" {
  type = "Microsoft.AVS/privateClouds/addons@2021-12-01"

  # Resource Name must match the addonType
  name      = "HCX"
  parent_id = azurerm_vmware_private_cloud.privatecloud.id

  body = {
    properties = {
      addonType = "HCX"
      offer     = "VMware MaaS Cloud Provider"
    }
  }

  lifecycle {
    ignore_changes = [
      parent_id
    ]
  }
}

# Wait for HCX addon registration before creating keys
resource "time_sleep" "wait_hcx" {
  depends_on      = [azapi_resource.hcx_addon]
  create_duration = var.hcx_wait_time
}

# Create HCX activation keys
resource "azapi_resource" "hcx_keys" {
  for_each = toset(var.hcx_key_names)

  type                   = "Microsoft.AVS/privateClouds/hcxEnterpriseSites@2022-05-01"
  name                   = each.key
  parent_id              = azurerm_vmware_private_cloud.privatecloud.id
  response_export_values = ["*"]

  depends_on = [
    time_sleep.wait_hcx,
    azapi_resource.hcx_addon
  ]

  lifecycle {
    ignore_changes = [
      parent_id
    ]
  }

  timeouts {
    create = "2h"
    delete = "2h"
  }
}

resource "azurerm_management_lock" "this_private_cloud" {
  lock_level = "CanNotDelete"
  name       = "${var.prefix}-lock"
  scope      = azurerm_vmware_private_cloud.privatecloud.id
  notes      = "Protected AVS Private Cloud resource. Do not delete."
}