variable "aws_account_id" {
  type    = "string"
  default = "589133037702"
}

variable "aws_region" {
  type    = "string"
  default = "eu-west-2"
}

variable "aws_az_a" {
  type    = "string"
  default = "eu-west-2a"
}

variable "aws_az_b" {
  type    = "string"
  default = "eu-west-2b"
}

provider "aws" {
  allowed_account_ids = ["${var.aws_account_id}"]
  region              = "${var.aws_region}"
}

variable "dns_zone_name" {
    type = "string"
    default = "service.hmpps.dsd.io"
}

variable "elastic-beanstalk-single-docker" {
  type    = "string"
  default = "64bit Amazon Linux 2017.09 v2.9.2 running Docker 17.12.0-ce"
}

locals {
  elb_ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01"
}
