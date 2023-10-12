variable "appname" {
  type        = string
  description = "The appname used for all resources"
  default     = "eshop-us-dev-ocelot"
}

variable "location" {
  type        = string
  description = "The Azure location used to create resources"
  default     = "East US"
}

variable "rgname" {
  type        = string
  description = "The Azure resource group name"
  default     = "EShop-RG"
}
