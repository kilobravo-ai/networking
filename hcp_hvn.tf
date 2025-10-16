# see https://registry.terraform.io/modules/ksatirli/hvn-azure/hcp/
module "hvn_azure" {
  # see https://developer.hashicorp.com/terraform/language/modules/develop/providers
  providers = {
    hcp = hcp.us
  }

  # see https://registry.terraform.io/modules/ksatirli/hvn-azure/hcp/latest
  source  = "ksatirli/hvn-azure/hcp"
  version = "1.1.0"

  identifier          = local.hvn_identifier
  cidr_block          = var.hcp_us_hvn_azure_cidr_block
  region              = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  routing_table_cidrs = var.hcp_us_hvn_azure_routing_table_cidrs
  subscription_id     = data.azurerm_subscription.main.subscription_id
  tenant_id           = data.azurerm_subscription.main.tenant_id
  vnet_name           = azurerm_virtual_network.main.name
}
