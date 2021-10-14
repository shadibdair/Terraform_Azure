# Author Shadi Badir

# Generic Input Variables
# Author
variable "author" {
  description = "This Infrastructure belongs to shadi badir"
  type = string
  default = "shadi"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "preprod"
}

# Azure Resource Group Name 
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg"  
}

# Azure Resources Location
variable "resource_group_location" {
  description = "Region in which Azure Resources to be created"
  type = string
  default = "westeurope"  
}
