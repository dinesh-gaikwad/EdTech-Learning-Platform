variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "ap-south-1"
}

variable "instance_type" {

  description = "EC2 Instance Type"

  type = string

  default = "t3.medium"
}

variable "ec2_ami" {

  description = "Ubuntu EC2 AMI"

  type = string

  default = "ami-0f58b397bc5c1f2e8"
}

variable "key_pair_name" {

  description = "AWS Key Pair Name"

  type = string

  default = "edtech-key"
}
