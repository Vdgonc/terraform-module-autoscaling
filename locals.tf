locals {
    region = lookup(var.aws_region, terraform.workspace)
}