# see https://registry.terraform.io/providers/hashicorp/azurerm/4.50.0/docs
provider "azurerm" {
  features {}

  subscription_id = var.azurerm_subscription_id
  use_cli         = true
}

# see https://registry.terraform.io/providers/hashicorp/azuread/3.6.0/docs
provider "azuread" {
  tenant_id = data.azurerm_subscription.main.tenant_id
}

# The HashiCorp Cloud Platform (HCP) Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs#authentication
provider "hcp" {
  # see https://developer.hashicorp.com/terraform/language/block/provider#alias
  alias = "us"

  # use an Admin-level Service Principal for access to HCP Project management features
  # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/guides/auth#client-credentials
  client_id     = var.hcp_us_admin_id
  client_secret = var.hcp_us_admin_secret

  # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs#geography-1
  geography = "us"

  project_id = var.hcp_us_default_project_id

  # see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs#skip_status_check-3
  skip_status_check = false
}
