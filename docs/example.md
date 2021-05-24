# Exemplo

```hcl
module "asg" {
    source = "https://github.com/Vdgonc/terraform-module-autoscaling.git"

    
    name = "webserver"
    key_name = "vdgonc"
    vpc_id = "vpc-8dc790e5"


    ami_owner = "self"
    ami_name = "webserver-linkfree-*"

    # valores default
    # ami_owner = "099720109477"
    # ami_name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"

    # utilização de scripts ao iniciar a instancia
    use_user_data = true
    user_data_path = "user-data.sh"

    # email para notificação dos alertas
    sns_email = "teste@teste.com"

    # configuração de autoscaling
    min_size = 1
    max_size = 1
    desired_capacity = 1

    # regras de security group
    ingress_rules = var.ig_rules

    # configuração do cloudwatch agent para métricas
    cw_config_file = "cw_agent_config.json"
}

variable "ig_rules" {
    type = list(object(
        {
            description = string
            from_port = number
            to_port = number
            protocol = string
            cidr_blocks = list(string)
        }
    ))
    default = [
        {
            description = "SSH - acesso por private ip"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["172.32.0.0/0"]
        },
        {
            description = "HTTP Access"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            description = "HTTPs Access"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}
```