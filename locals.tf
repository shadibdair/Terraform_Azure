# Define Local Values in Terraform
locals {
  owners = var.author
  environment = var.environment
  resource_name_prefix = "${var.author}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 