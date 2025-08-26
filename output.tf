#Why

#Exposes kubeconfig → fed into pipeline for deployments.

#Can be injected into Azure DevOps pipeline variables.

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}



