resource "aws_launch_template" "lt" {
    name = var.name
    image_id = data.aws_ami.ubuntu.id
    instance_type = var.instance_type

    block_device_mappings {
        device_name = "/dev/sda1"
        ebs {
            volume_size = 8
            volume_type = "gp3"
        }
    }

    key_name = local.key_name

    monitoring {
        enabled = true
    }    

    tags = {
        Name = var.name
    }

    user_data = var.use_user_data ? filebase64(var.user_data_path) : null
}

resource "aws_autoscaling_group" "asg" {
    name_prefix = join("-", [var.name, "asg"])
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
}
