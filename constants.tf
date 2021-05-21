variable "aws_region" {
    type = map(string)
    description = "AWS Region"
    default = {
        default = "us-east-2"
        staging = "us-east-2"
        prod = "us-east-2"
    }
}