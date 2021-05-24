# Variaveis

---

Nome: `vpc_id`

Descrição: Id da vpc onde os recursos serão criados.

Default:

---

Nome: `ami_owner`

Descrição: Proprietario da AMI base.

Default: "099720109477" (Canonical)

---

Nome: `ami_name`

Descrição: Nome da AMI base.

Default: "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"

---

Nome: `instance_type`

Descrição: Familia da instância

Default: "t2.micro"

---

Nome: `key_name`

Descrição: Nome da chave de acesso.

Default: 

---

Nome: `use_user_data`

Descrição: Ativa uso de script na inicialização da instancia.

Default: true

---

Nome: `user_data_path`

Descrição: Path do script

Default:

---

Nome: `name`

Descrição: Nome para instancias e autoscaling.

Default:

---

Nome: `min_size`

Descrição: Número minimo de instancias no autoscaling group

Default: 1

---

Nome: `max_size`

Descrição: Número maximo de instancias no autoscaling group

Default: 1

---

Nome: `desired_capacity`

Descrição: Número desejado de instancias no autoscaling group

Default: 1

---

Nome: `ingress_rules`

Descrição: Regras de entrada no security group

Default: [
        {
            description = "SSH Access"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["172.31.0.0/16"]
        }]

---

Nome: `egress_rules`

Descrição: Regras de saída no security group

Default: [
        {
            description = "Allow all trafic for egress"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }]

---

Nome: `use_email_notification`

Descrição: Utilização de email para alertas

Default: true

---

Nome: `sns_email`

Descrição: Email cadastrado no topico do SNS

Default:

---

Nome: `cw_config_file`

Descrição: JSON de configuração do CloudWatch Agent

Default:

---
