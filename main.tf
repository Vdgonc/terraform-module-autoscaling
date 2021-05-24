provider "aws" {
    region = local.region
}

data "aws_vpc" "vpc" {
    id = var.vpc_id
}

data "aws_subnet_ids" "subnets_id" {
    vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnet" "subnets" {
    for_each = data.aws_subnet_ids.subnets_id.ids
    id = each.value
}

data "aws_ami" "ubuntu" {
    owners = [var.ami_owner]
    most_recent = true

    filter {
        name = "name"
        values = [var.ami_name]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}