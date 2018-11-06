variable "cluster_name" {
  default = "test"
}

variable "cluster_size" {
  default = 3
}

variable "health_check_type" {
  default = "EC2"
}

variable "ami_id" {
  default = "ami-0b59bfac6be064b78" #Amazon Linux Ami
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_zone_identifier" {
  type = "list"
}

variable "elb_name" {
  default = "loadbalancer"
}

variable "ec2_port" {
  default = 8080
}

variable "vpc_id" {}

variable "lb_port" {
  default = 80
}

variable "project_name" {
  default = "project-test"
}

variable "codebuild_compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_image" {
 default = "aws/codebuild/java:openjdk-8"
}

variable "codebuild_bucket" {
  default = "testtask-artifacts"
}