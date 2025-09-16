variable "privatecloud_id" {
  description = "The ID of the AVS private cloud where HCX will be deployed"
  type        = string
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