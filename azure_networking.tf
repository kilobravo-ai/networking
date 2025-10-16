# see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/data-sources/subscription
data "azurerm_subscription" "main" {
  subscription_id = var.azurerm_subscription_id
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
data "azurerm_resource_group" "main" {
  name = var.project_identifier
}

locals {
  azure_network_identifier = "${data.azurerm_resource_group.main.name}-hvn"
  hvn_identifier           = "${data.azurerm_resource_group.main.name}-${data.azurerm_resource_group.main.location}"
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/4.47.0/docs/resources/route_table
resource "azurerm_route_table" "main" {
  location            = data.azurerm_resource_group.main.location
  name                = local.azure_network_identifier
  resource_group_name = data.azurerm_resource_group.main.name
}

# Set up DDoS plan; note that Azure limits the amount of plans to one per region
# ⚠️ For the cost associated with this service, see https://learn.microsoft.com/en-us/azure/ddos-protection/ddos-protection-overview
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan
resource "azurerm_network_ddos_protection_plan" "main" {
  count = var.azurerm_network_ddos_protection_enabled ? 1 : 0

  location            = data.azurerm_resource_group.main.location
  name                = local.azure_network_identifier
  resource_group_name = data.azurerm_resource_group.main.name
}

# create virtual network for use with the HVN
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "main" {
  address_space = var.azurerm_virtual_network_address_space

  # Enabling DDoS protection results in meeting Best Practices as defined by Snyk: https://snyk.io/security-rules/SNYK-CC-AZURE-516
  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#ddos_protection_plan
  dynamic "ddos_protection_plan" {
    # Iterate over the DDoS plan resources directly. When count = 0 this is an empty
    # list and the block is not rendered; when count = 1 it will render once.
    for_each = azurerm_network_ddos_protection_plan.main

    content {
      id     = each.value.id
      # This field is only meaningful when the block exists; keep it tied to the variable.
      enable = var.azurerm_network_ddos_protection_enabled
    }
  }

  name                = local.azure_network_identifier
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/4.47.0/docs/resources/network_security_group
resource "azurerm_network_security_group" "main" {
  location            = data.azurerm_resource_group.main.location
  name                = local.azure_network_identifier
  resource_group_name = data.azurerm_resource_group.main.name
}
