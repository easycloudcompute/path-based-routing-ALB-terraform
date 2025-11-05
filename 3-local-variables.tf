# Define Local Values in Terraform
locals {
  environment = var.environment
  name        = "${var.application}-${var.environment}"
  tags = {
    environment = local.environment
  }
}