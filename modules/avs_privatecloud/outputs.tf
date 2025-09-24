output "privatecloud_id" {
  value = azurerm_vmware_private_cloud.privatecloud.id
}

output "hcx_keys" {
  description = "Map of HCX key names to activation keys"
  value = {
    for key, value in azapi_resource.hcx_keys :
    key => jsondecode(value.output).properties.activationKey
  }
}

output "nsxt_password" {
  value     = random_password.nsxt.result
  sensitive = true
}

output "vcenter_password" {
  value     = random_password.vcenter.result
  sensitive = true
}