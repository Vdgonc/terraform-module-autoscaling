resource "aws_ssm_parameter" "parameter" {
    name = "/cloudwatch-agent/config"
    type = "String"
    value = file(var.cw_config_file)
}