variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources into"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry name (must be globally unique)"
  type        = string
}

variable "aks_name" {
  description = "Azure Kubernetes Service (AKS) cluster name"
  type        = string
}
