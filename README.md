# Terraform Module AutoScaling

---

Terraform module criado para provisionar instâncias gerenciadas por autoscaling.

## Descrição:

Este módulo cria instâncias com regras para de IAM e acesso via SSM para coletar métricas via CloudWatch Agent.

Também são criados 3 alertas no CloudWatch:

* Número de instâncias `running` por autoscaling group
* Consumo de CPU em porcentagem
* Consumo de memória RAM em porcentagem


Para utilizar o módulo é necessario configurar as [variaveis](docs/vars.md) como no [exemplo](docs/example.md).

## Recursos criados

```
  # module.asg.aws_autoscaling_group.asg will be created
  + resource "aws_autoscaling_group" "asg" {
      + arn                       = (known after apply)
      + availability_zones        = (known after apply)
      + default_cooldown          = (known after apply)
      + desired_capacity          = 1
      + enabled_metrics           = [
          + "GroupInServiceCapacity",
          + "GroupPendingCapacity",
          + "GroupTotalInstances",
        ]
      + force_delete              = false
      + force_delete_warm_pool    = false
      + health_check_grace_period = 300
      + health_check_type         = (known after apply)
      + id                        = (known after apply)
      + max_size                  = 1
      + metrics_granularity       = "1Minute"
      + min_size                  = 1
      + name                      = "webserver-asg-prod"
      + protect_from_scale_in     = false
      + service_linked_role_arn   = (known after apply)
      + termination_policies      = [
          + "OldestInstance",
          + "OldestLaunchTemplate",
        ]
      + vpc_zone_identifier       = [
          + "subnet-4a5fb806",
          + "subnet-c83275a0",
          + "subnet-fe11ac84",
        ]
      + wait_for_capacity_timeout = "10m"

      + launch_template {
          + id      = (known after apply)
          + name    = (known after apply)
          + version = (known after apply)
        }

      + tag {
          + key                 = "Environment"
          + propagate_at_launch = false
          + value               = "prod"
        }
    }

  # module.asg.aws_cloudwatch_metric_alarm.cpu_utilization will be created
  + resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
      + actions_enabled                       = true
      + alarm_actions                         = (known after apply)
      + alarm_description                     = "This metric monitors cpu utilization running instances"
      + alarm_name                            = "CPU utilization: webserver-asg-prod"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + dimensions                            = {
          + "AutoScalingGroupName" = "webserver-asg-prod"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "CPUUtilization"
      + namespace                             = "AWS/EC2"
      + ok_actions                            = (known after apply)
      + period                                = 180
      + statistic                             = "Average"
      + tags_all                              = (known after apply)
      + threshold                             = 80
      + treat_missing_data                    = "missing"
    }

  # module.asg.aws_cloudwatch_metric_alarm.instance_number will be created
  + resource "aws_cloudwatch_metric_alarm" "instance_number" {
      + actions_enabled                       = true
      + alarm_actions                         = (known after apply)
      + alarm_description                     = "This metric monitors running instances"
      + alarm_name                            = "Active instances for: webserver-asg-prod"
      + arn                                   = (known after apply)
      + comparison_operator                   = "LessThanThreshold"
      + dimensions                            = {
          + "AutoScalingGroupName" = "webserver-asg-prod"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "GroupTotalInstances"
      + namespace                             = "AWS/AutoScaling"
      + ok_actions                            = (known after apply)
      + period                                = 180
      + statistic                             = "Average"
      + tags_all                              = (known after apply)
      + threshold                             = 1
      + treat_missing_data                    = "missing"
    }

  # module.asg.aws_cloudwatch_metric_alarm.mem_utilization will be created
  + resource "aws_cloudwatch_metric_alarm" "mem_utilization" {
      + actions_enabled                       = true
      + alarm_actions                         = (known after apply)
      + alarm_description                     = "This metric monitors memory utilization running instances"
      + alarm_name                            = "Memory utilization: webserver-asg-prod"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + dimensions                            = {
          + "AutoScalingGroupName" = "webserver-asg-prod"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "mem_available_percent"
      + namespace                             = "CWAgent"
      + ok_actions                            = (known after apply)
      + period                                = 180
      + statistic                             = "Average"
      + tags_all                              = (known after apply)
      + threshold                             = 80
      + treat_missing_data                    = "missing"
    }

  # module.asg.aws_iam_instance_profile.profile will be created
  + resource "aws_iam_instance_profile" "profile" {
      + arn         = (known after apply)
      + create_date = (known after apply)
      + id          = (known after apply)
      + name        = "webserver_instance_profile"
      + path        = "/"
      + role        = "webserver_role"
      + tags_all    = (known after apply)
      + unique_id   = (known after apply)
    }

  # module.asg.aws_iam_role.role will be created
  + resource "aws_iam_role" "role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ec2.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "webserver_role"
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.asg.aws_iam_role_policy.rl_policy will be created
  + resource "aws_iam_role_policy" "rl_policy" {
      + id     = (known after apply)
      + name   = "webserver_role_policy"
      + policy = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "ssm:GetParameter",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + role   = (known after apply)
    }

  # module.asg.aws_iam_role_policy_attachment.attachment[0] will be created
  + resource "aws_iam_role_policy_attachment" "attachment" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
      + role       = "webserver_role"
    }

  # module.asg.aws_iam_role_policy_attachment.attachment[1] will be created
  + resource "aws_iam_role_policy_attachment" "attachment" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      + role       = "webserver_role"
    }

  # module.asg.aws_launch_template.lt will be created
  + resource "aws_launch_template" "lt" {
      + arn                    = (known after apply)
      + default_version        = (known after apply)
      + id                     = (known after apply)
      + image_id               = "ami-02846a49cae0659d1"
      + instance_type          = "t2.micro"
      + key_name               = "vdgonc"
      + latest_version         = (known after apply)
      + name                   = "webserver"
      + name_prefix            = (known after apply)
      + tags_all               = (known after apply)
      + user_data              = "IyEvYmluL2Jhc2gKc3VkbyBhcHQgdXBkYXRlIAoKZGF0ZSA+IC9ob21lL3VidW50dS91c2VyLWRhdGEubG9nCgpzdWRvIGNlcnRib3QgcmVuZXcgLS1kcnktcnVuIC1uIHwgdGVlIC1hIC9ob21lL3VidW50dS91c2VyLWRhdGEubG9nCgpkYXRlID4+IC9ob21lL3VidW50dS91c2VyLWRhdGEubG9nCg=="
      + vpc_security_group_ids = (known after apply)

      + block_device_mappings {
          + device_name = "/dev/sda1"

          + ebs {
              + iops        = (known after apply)
              + throughput  = (known after apply)
              + volume_size = 8
              + volume_type = "gp3"
            }
        }

      + iam_instance_profile {
          + name = "webserver_instance_profile"
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + monitoring {
          + enabled = true
        }

      + tag_specifications {
          + resource_type = "instance"
          + tags          = {
              + "Environment" = "prod"
              + "Name"        = "webserver"
            }
        }
    }

  # module.asg.aws_security_group.sg will be created
  + resource "aws_security_group" "sg" {
      + arn                    = (known after apply)
      + description            = (known after apply)
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "webserver_sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Environment" = "prod"
          + "Name"        = "webserver_sg"
        }
      + tags_all               = {
          + "Environment" = "prod"
          + "Name"        = "webserver_sg"
        }
      + vpc_id                 = "vpc-8dc790e5"
    }

  # module.asg.aws_security_group_rule.eg_rules["0"] will be created
  + resource "aws_security_group_rule" "eg_rules" {
      + cidr_blocks              = [
          + "0.0.0.0/0",
        ]
      + description              = "Allow all trafic for egress"
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 0
      + type                     = "egress"
    }

  # module.asg.aws_security_group_rule.ig_rules["0"] will be created
  + resource "aws_security_group_rule" "ig_rules" {
      + cidr_blocks              = [
          + "179.96.128.169/32",
        ]
      + description              = "SSH Access"
      + from_port                = 22
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 22
      + type                     = "ingress"
    }

  # module.asg.aws_security_group_rule.ig_rules["1"] will be created
  + resource "aws_security_group_rule" "ig_rules" {
      + cidr_blocks              = [
          + "0.0.0.0/0",
        ]
      + description              = "HTTP Access"
      + from_port                = 80
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 80
      + type                     = "ingress"
    }

  # module.asg.aws_security_group_rule.ig_rules["2"] will be created
  + resource "aws_security_group_rule" "ig_rules" {
      + cidr_blocks              = [
          + "0.0.0.0/0",
        ]
      + description              = "HTTPs Access"
      + from_port                = 443
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 443
      + type                     = "ingress"
    }

  # module.asg.aws_sns_topic.topic will be created
  + resource "aws_sns_topic" "topic" {
      + arn                         = (known after apply)
      + content_based_deduplication = false
      + fifo_topic                  = false
      + id                          = (known after apply)
      + name                        = "webserver-notification-topic"
      + name_prefix                 = (known after apply)
      + policy                      = (known after apply)
      + tags                        = {
          + "Environment" = "prod"
        }
      + tags_all                    = {
          + "Environment" = "prod"
        }
    }

  # module.asg.aws_sns_topic_subscription.email_sub[0] will be created
  + resource "aws_sns_topic_subscription" "email_sub" {
      + arn                             = (known after apply)
      + confirmation_timeout_in_minutes = 1
      + confirmation_was_authenticated  = (known after apply)
      + endpoint                        = "justdgoncalves@gmail.com"
      + endpoint_auto_confirms          = false
      + id                              = (known after apply)
      + owner_id                        = (known after apply)
      + pending_confirmation            = (known after apply)
      + protocol                        = "email"
      + raw_message_delivery            = false
      + topic_arn                       = (known after apply)
    }

  # module.asg.aws_ssm_parameter.parameter will be created
  + resource "aws_ssm_parameter" "parameter" {
      + arn       = (known after apply)
      + data_type = (known after apply)
      + id        = (known after apply)
      + key_id    = (known after apply)
      + name      = "/cloudwatch-agent/config"
      + tags_all  = (known after apply)
      + tier      = "Standard"
      + type      = "String"
      + value     = (sensitive value)
      + version   = (known after apply)
    }


```