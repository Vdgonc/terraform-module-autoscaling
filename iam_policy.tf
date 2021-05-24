resource "aws_iam_role" "role" {
    name = join("_", [var.name, "role"])
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role_policy" "rl_policy" {
    name = join("_", [var.name, "role_policy"])
    role = aws_iam_role.role.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "ssm:GetParameter"
                ]
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "attachment" {
    count = length(local.role_policy_arns)

    role = aws_iam_role.role.name
    policy_arn = element(local.role_policy_arns, count.index)
}

resource "aws_iam_instance_profile" "profile" {
    name = join("_", [var.name, "instance_profile"])
    role = aws_iam_role.role.name
}