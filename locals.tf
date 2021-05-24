locals {
    region = lookup(var.aws_region, terraform.workspace)
    key_name = var.key_name != "" ? var.key_name : null
    date = formatdate("MMM DD, YYYY", timestamp())
    date_alt = formatdate("YYYY-MM-DD", timestamp())
    role_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]
}