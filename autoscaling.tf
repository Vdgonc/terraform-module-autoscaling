resource "aws_launch_template" "lt" {
    name = var.name
    image_id = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sg.id ]

    block_device_mappings {
        device_name = "/dev/sda1"
        ebs {
            volume_size = 8
            volume_type = "gp3"
        }
    }

    key_name = local.key_name

    iam_instance_profile {
        name = aws_iam_instance_profile.profile.name
    }

    monitoring {
        enabled = true
    }    

    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = var.name
            Environment = terraform.workspace
        }
    }

    user_data = var.use_user_data ? filebase64(var.user_data_path) : null
}

resource "aws_autoscaling_group" "asg" {
    name = join("-", [var.name, "asg", terraform.workspace, local.date_alt])
    desired_capacity = var.desired_capacity
    min_size = var.min_size
    max_size = var.max_size

    launch_template {
        id = aws_launch_template.lt.id
        version = aws_launch_template.lt.latest_version
    }

    vpc_zone_identifier = data.aws_subnet_ids.subnets_id.ids

    enabled_metrics = ["GroupInServiceCapacity", "GroupPendingCapacity","GroupTotalInstances"]

    termination_policies = [ "OldestInstance", "OldestLaunchTemplate" ]
    
    tag {
        key = "Environment"
        value = terraform.workspace
        propagate_at_launch = false
    }
}


output "launch_template_id" {
    description = "Lauch Template Id"
    value = aws_launch_template.lt.id
}

output "asg_name" {
    description = "AutoScaling Group Name"
    value = aws_autoscaling_group.asg.name
}

output "asg_arn" {
    description = "AutoScaling Group ARN"
    value = aws_autoscaling_group.asg.arn
}
