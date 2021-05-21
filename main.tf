provisioner "aws" {
    local.region
}

data "aws_vpc" "vpc" {
    id = var.vpc_id
}