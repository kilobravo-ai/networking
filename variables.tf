variable "azurerm_subscription_id" {
  type        = string
  description = "Azure Subscription ID."
}

# ⚠️ For the cost associated with this service, see https://learn.microsoft.com/en-us/azure/ddos-protection/ddos-protection-overview
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan
variable "azurerm_network_ddos_protection_enabled" {
  type        = bool
  description = "Enable DDoS Protection on the Virtual Network."
  default     = false
}

variable "azurerm_virtual_network_address_space" {
  type        = list(string)
  description = "The Address Space that is used by the Azure Virtual Network."

  default = [
    "10.0.0.0/16"
  ]
}

variable "hcp_us_admin_id" {
  type        = string
  description = "Admin-level Service Principal Client ID for HCP US."
}

variable "hcp_us_admin_secret" {
  type        = string
  description = "Admin-level Service Principal Client Secret for HCP US."
  sensitive   = true
}

variable "hcp_us_default_project_id" {
  type        = string
  description = "Default Project Identifier for HCP US."
}

variable "hcp_us_hvn_azure_cidr_block" {
  type        = string
  description = "The CIDR range of the HVN."
  default     = "172.25.16.0/20"
}

variable "hcp_us_hvn_azure_routing_table_cidrs" {
  type = list(object({
    name = string
    cidr = string
  }))

  description = "List of Objects containing Name and CIDR for (multiple) HVN Routing Tables."

  default = [
    {
      name = "management"
      cidr = "172.16.0.0/16"
      }, {
      name = "platform"
      cidr = "172.26.0.0/16"
    }
  ]
}

variable "project_identifier" {
  type        = string
  description = "Project Identifier."
  default     = "kilobravo-ai"
}
