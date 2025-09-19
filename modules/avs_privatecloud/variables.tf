variable "prefix" {
    default = "avs"
}
variable "env" {}
variable "region" {}
variable "resource_group_name" {}
variable "sku_name" {}
variable "management_host_count" {}
variable "network_cidr" {}
variable "nsxt_password" { sensitive = true }
variable "vcenter_password" { sensitive = true }
variable "tags" { 
    type = map(string)
    default = {}
     }