resource "azurerm_management_lock" "this_private_cloud" {
  lock_level = "CanNotDelete"
  name       = "${var.prefix}-lock"
  scope      = var.privatecloud_id
  notes      = "Protected AVS Private Cloud resource. Do not delete."
}