provider "azurerm" {
  features {}
}

resource "random_pet" "pet" {
  keepers = {
    # Generate a new pet name each time we switch to a new AMI id
  }
  separator = ""

}
#################
# pre-requisites
#################

module "resourcegroup" {
  source  = "bytejunkie/resource-group/azurerm"
  version = "1.0.1"

  location       = "west europe"
  name_strings   = ["byt", "rsg", random_pet.pet.id]
  name_separator = "-"

  #   tags = var.tags
}

module "storage_account" {
  source  = "bytejunkie/storage-account/azurerm"
  version = "1.0.1"

  name_strings        = ["byt", "sto", random_pet.pet.id]
  resource_group_name = module.resourcegroup.resource_group_name
  location            = "west europe"

  depends_on = [
    module.resourcegroup
  ]

  tags = {
    location = "west europe"
  }
}

module "container" {
  source = "../../"

  container_name       = random_pet.pet.id
  storage_account_name = module.storage_account.storage_account.name
}
