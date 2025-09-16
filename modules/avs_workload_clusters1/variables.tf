variable "cluster_name" {
  type        = string
  description = "Name of the AVS cluster"
}

variable "privatecloud_id" {}

variable "cluster_node_count" {
  type = number
  description = "Number of nodes in the cluster"
  validation {
    condition     = var.cluster_node_count >= 3
    error_message = "Cluster node count must be at least 3"
  }
}
variable "sku_name" {
  type = string
}