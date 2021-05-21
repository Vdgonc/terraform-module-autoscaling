locals {
    region = lookup(var.aws_region, terraform.workspace)
    key_name = var.key_name != "" ? var.key_name : null
}