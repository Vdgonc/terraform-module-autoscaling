variable "vpc_id" {
    type = string
    description = "AWS VPC Id"
}

variable "ami_owner" {
    type = string
    description = "Owner of ami (aws account id)"
    default = "099720109477"
}

variable "ami_name" {
    type = string
    description = "AMI name"
    default = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}
variable "instance_type" {
    type = string
    description = "Instance Type"
    default = "t2.micro"
}

variable "key_name" {
    type = string
    description = "SSH key"
}

variable "use_user_data" {
    type = bool
    description = "Use userdata when init the instances"
    default = true
}

variable "user_data_path" {
    type = string
    description = "Path of file with the user data script"
}

variable "name" {
    type = string
    description = "Application name"
}

variable "min_size" {
    type = number
    description = "Min size of instances on Auto Scaling Group"
    default = 1
}

variable "max_size" {
    type = number
    description = "Max size of instances on Auto Scaling Group"
    default = 1
}

variable "desired_capacity" {
    type = number
    description = "Desired capacity of instances on Auto Scaling Group"
    default = 1
}

variable "ingress_rules" {
    type = list(object(
        {
            description = string
            from_port = number
            to_port = number
            protocol = string
            cidr_blocks = list(string)
        }
    ))
    description = "Security group ingress rules"
    default = [
        {
            description = "SSH Access"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["172.31.0.0/16"]
        }
    ]
}

variable "egress_rules" {
    type = list(object(
        {
            description = string
            from_port = number
            to_port = number
            protocol = string
            cidr_blocks = list(string)
        }
    ))
    description = "Security group ingress rules"
    default = [
        {
            description = "Allow all trafic for egress"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}

variable "use_email_notification" {
    type = bool
    description = "Enable email notification"
    default = true
}
variable "sns_email" {
    type = string
    description = "SNS email subscription"
}

variable "cw_config_file" {
    type = string
    description = "CloudWatch config file"
}