# Author Shadi Badir

# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet"
}

variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}