variable "prefix" {
    default = "avs"
}
variable "env" {}
variable "region" {}
variable "resource_group_name" {}
variable "sku_name" {}
variable "management_host_count" {}
variable "network_cidr" {}
variable "tags" { 
    type = map(string)
    default = {}
     }

variable "hcx_wait_time" {
  description = "Wait time before creating HCX keys (e.g., 120s)"
  type        = string
  default     = "120s"
}

variable "hcx_key_names" {
  description = "List of HCX key names to generate"
  type        = list(string)
}

variable "environment" {
  description = "Environment tag (e.g., Production, Dev)"
  type        = string
  default     = "Production"
}