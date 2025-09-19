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

variable "mandatory_tags" {
  type = map(string)
  default = {
    "APP"  = "AVS"
    "DEPT" = "IT"
    "ENV"  = "DEV"
  }
}

variable "avs_config" {
  description = "Map of AVS clusters to deploy"
  type = map(object({
    network_cidr          = string
    sku                   = string
    mgmt_host_count       = string

  }))
}

variable "clusters" {
  description = "Map of AVS clusters to deploy"
  type = map(object({
    name         = string
    host_count   = number
    sku          = string
  }))
}

variable "hcx_key_names" {
  type        = list(string)
  description = "list of key names to use when generating hcx site activation keys."
  default     = []
  validation {
    condition     = length(var.hcx_key_names) <= 5 # HCX has a limit on number of keys
    error_message = "Maximum of 5 HCX keys can be created per Private Cloud."
  }
}

variable "hcx_wait_time" {
  type        = string
  description = "Wait time for HCX registration (in seconds)"
  default     = "120s"
}

variable "subscription_id" {}
