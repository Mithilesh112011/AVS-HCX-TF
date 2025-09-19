#-----------------------------------------------------------------
# DO NOT CHANGE
# Update any variables from the terraform.tfvars file as required
#-----------------------------------------------------------------

variable "prefix" {
  type        = string
  description = "Prefix to be used for resource naming"
}

variable "env" {
  type        = string
  description = "Environment to be used for resource naming"
}

variable "region" {
  type        = string
  description = "Azure region where resources will be deployed"
}

variable "avs_configs" {
  type = list(object({
    sku             = string
    mgmt_host_count = number
    network_cidr    = string
  }))
}

variable "mandatory_tags" {
  type = map(string)
  default = {
    "APP"  = "AVS"
    "DEPT" = "IT"
    "ENV"  = "DEV"
  }
}

variable "avs-network_cidr" {
  type        = string
  description = "CIDR block for AVS private cloud"
}

variable "avs_config" {
  description = "Map of AVS clusters to deploy"
  type = list(object({
    sku             = string
    mgmt_host_count = number
    network_cidr    = string
  }))
}

variable "avs-management_host_count" {
  type        = number
  default     = 4
  description = "Number of hosts in the AVS cluster"
  validation {
    condition     = var.avs-management_host_count >= 3
    error_message = "AVS requires a minimum of 3 hosts."
  }
}


variable "clusters" {
  description = "Map of AVS clusters to deploy"
  type = map(object({
    name         = string
    host_count   = number
    sku          = string
    network_cidr = string
  }))
}


variable "adminusername" {
  type = string
}

/* variable "jumpboxsku" {
  type    = string
  default = "Standard_D2as_v4"
}
*/

variable "vnetaddressspace" {
  type = string
}

variable "gatewaysubnet" {
  type = string
}

/*
variable "azurebastionsubnet" {
  type = string
}


variable "jumpboxsubnet" {
  type = string
}
*/

variable "hcx_key_names" {
  type        = list(string)
  description = "list of key names to use when generating hcx site activation keys."
  default     = []
  validation {
    condition     = length(var.hcx_key_names) <= 5 # HCX has a limit on number of keys
    error_message = "Maximum of 5 HCX keys can be created per Private Cloud."
  }
}

variable "key_vault_name" {
  type        = string
  description = "The name for the key vault used to store the jump virtual machine password."
}

variable "nsg_name" {
  type        = string
  description = "The name to use for the default NSG deployed with the networks."
}

variable "telemetry_enabled" {
  type        = bool
  description = "toggle the telemetry on/off for this module"
  default     = true
}

variable "hcx_wait_time" {
  type        = string
  description = "Wait time for HCX registration (in seconds)"
  default     = "120s"
}


variable "subscription_id" {}
variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {
  sensitive = true
}

variable "tags" {
  type = string
}