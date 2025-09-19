# Deploy the HCX Addon
terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
      version = ">=2.0.0"
    }
  }
}

resource "azapi_resource" "hcx_addon" {
  type = "Microsoft.AVS/privateClouds/addons@2021-12-01"

  # Resource Name must match the addonType
  name      = "HCX"
  parent_id = var.privatecloud_id

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
  parent_id              = var.privatecloud_id
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