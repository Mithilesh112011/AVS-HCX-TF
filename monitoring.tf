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

resource "azurerm_monitor_metric_alert" "avs_CPUCritical" {
  name                = "CPUCritical-metricalert"
  resource_group_name = azurerm_resource_group.privatecloud.name
  scopes              = [module.avs_privatecloud.privatecloud_id]
  description         = "CPU Critical  alert per cluster"

  criteria {
    metric_namespace = "Microsoft.AVS/privateClouds"
    metric_name      = "EffectiveCpuAverage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95

    dimension {
      name     = "clustername"
      operator = "Include"
      values   = ["*"]
    }
  }
}

resource "azurerm_monitor_metric_alert" "avs_DiskUsedPercentage" {
  name                = "DiskUsedPercentage-metricalert"
  resource_group_name = azurerm_resource_group.privatecloud.name
  scopes              = [module.avs_privatecloud.privatecloud_id]
  description         = "Disk Used Percentage alert per cluster"

  criteria {
    metric_namespace = "Microsoft.AVS/privateClouds"
    metric_name      = "DiskUsedPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75

    dimension {
      name     = "dsname"
      operator = "Include"
      values   = ["*"]
    }
  }
}

resource "azurerm_monitor_metric_alert" "avs_Memory" {
  name                = "Memory-metricalert"
  resource_group_name = azurerm_resource_group.privatecloud.name
  scopes              = [module.avs_privatecloud.privatecloud_id]
  description         = "Memory alert per cluster"

  criteria {
    metric_namespace = "Microsoft.AVS/privateClouds"
    metric_name      = "UsageAverage"
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

resource "azurerm_monitor_metric_alert" "avs_MemoryCritical" {
  name                = "MemoryCritical-metricalert"
  resource_group_name = azurerm_resource_group.privatecloud.name
  scopes              = [module.avs_privatecloud.privatecloud_id]
  description         = "Memory Critical alert per cluster"

  criteria {
    metric_namespace = "Microsoft.AVS/privateClouds"
    metric_name      = "UsageAverage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95

    dimension {
      name     = "clustername"
      operator = "Include"
      values   = ["*"]
    }
  }
}

resource "azurerm_monitor_metric_alert" "avs_storage" {
  name                = "storage-metricalert"
  resource_group_name = azurerm_resource_group.privatecloud.name
  scopes              = [module.avs_privatecloud.privatecloud_id]
  description         = "storage alert per cluster"

  criteria {
    metric_namespace = "Microsoft.AVS/privateClouds"
    metric_name      = "DiskUsedPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 70

    dimension {
      name     = "dsname"
      operator = "Include"
      values   = ["*"]
    }
  }
}

resource "azurerm_monitor_metric_alert" "avs_UsageAverage"  {
  name                = "UsageAverage-metricalert"
  resource_group_name = azurerm_resource_group.privatecloud.name
  scopes              = [module.avs_privatecloud.privatecloud_id]
  description         = "Usage Average alert per cluster"

  criteria {
    metric_namespace = "Microsoft.AVS/privateClouds"
    metric_name      = "UsageAverage"
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
