terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.6.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.88.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "onlydole"

    workspaces {
      name = "aks-in-action"
    }
  }
}

