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