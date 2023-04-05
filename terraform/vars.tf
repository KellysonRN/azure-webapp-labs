variable "location" {
  description = "Azure location this azure StorageAccount should reside in"
  type        = string
  default     = "eastus2"
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default = {
    "environment" = "dev"
  }
}

variable "rg" {
  description = "Resources Group"
  type        = string
  default     = "labs"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}


variable "proof_name" {
  description = "The name for api service"
  type        = string
  default     = "azurewebapplabs"
}

variable "force_destroy" {
  description = "Delete all objects from the StorageAccount so that the SA can be destroyed even when not empty"
  type        = bool
  default     = true
}
