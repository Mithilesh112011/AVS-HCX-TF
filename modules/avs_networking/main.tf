resource "azurerm_vmware_express_route_authorization" "expressrouteauthkey" {
  name             = "${var.prefix}-AVS"
  private_cloud_id = var.privatecloud_id
}