variable "vpc_id" {
    type = string
    description = "AWS VPC Id"
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