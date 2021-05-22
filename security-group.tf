resource "aws_security_group" "sg" {
    name = join("_", [var.name, "sg"])
    description = join(" ", ["Security Group",var.name, "created at", local.date])
    vpc_id = data.aws_vpc.vpc.id

    tags = {
        Name = join("_", [var.name, "sg"])
    }
}

resource "aws_security_group_rule" "eg_rules" {
    type = "ingress"
    security_group_id = aws_security_group.sg.id

    for_each = { for index, rules in  var.egress_rules : index => rules }
    from_port = each.value.from_port
    to_port = each.value.to_port
    protocol = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
}

resource "aws_security_group_rule" "ig_rules" {
    type = "ingress"
    security_group_id = aws_security_group.sg.id

    for_each = { for index, rules in  var.ingress_rules : index => rules }
    from_port = each.value.from_port
    to_port = each.value.to_port
    protocol = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
}