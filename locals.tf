# Author Shadi Badir

# Define Local Values in Terraform
locals {
  owners = var.author
  environment = var.environment
  resource_name_prefix = "${var.resource_group_location}-${var.author}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 