terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.21.1"
    }
  }
    backend "azurerm" {
    resource_group_name  = "Donot-Delete-RG"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "cptstg0811"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "Prod.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  features {
    
    }
    subscription_id =  "6f6bd52c-44e1-405f-a97b-2cd639f80d31"
}