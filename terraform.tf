terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/cloud
  cloud {
    # see https://developer.hashicorp.com/terraform/language/block/terraform#hostname
    # hostname = "<value set in environment>"

    # see https://developer.hashicorp.com/terraform/cli/cloud/settings#organization
    # organization = "<value set in environment>"

    # see https://developer.hashicorp.com/terraform/cli/cloud/settings#workspaces
    workspaces {
      # see https://developer.hashicorp.com/terraform/cli/cloud/settings#workspaces-name
      name = "networking"

      # see https://developer.hashicorp.com/terraform/cli/cloud/settings#workspaces-project
      # project = "<value set in environment>"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azuread/3.8.0
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.8.0, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/azurerm/4.61.0
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.61.0, < 5.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/hcp/0.110.0
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.110.0, < 1.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.14.0, < 2.0.0"
}
