resource "azurerm_monitor_metric_alert" "avs_cpu" {
  name                = "cpu-metricalert"
  resource_group_name = azurerm_resource_group.privatecloud.name
  scopes              = [module.avs_privatecloud.privatecloud_id]
  description         = "CPU Usage per Cluster"

  criteria {
    metric_namespace = "Microsoft.AVS/privateClouds"
    metric_name      = "EffectiveCpuAverage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80

    dimension {
      name     = "clustername"
      operator = "Include"
      values   = ["*"]
    }
  }
}