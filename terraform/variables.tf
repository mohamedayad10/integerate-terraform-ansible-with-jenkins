variable "region" {
  description = "enter infra region"
  type        = string
}
variable "vpc_cidr" {
  description = "enter vpc cidr block"
  type        = string
}
variable "subnet_cidr" {
  description = "enter subnet cidr"
  type        = string
}
variable "available_zone" {
  description = "enter availability zone"
  type        = string
}
variable "environment" {
  description = "enter your working environment"
  type        = string
}
variable "image" {
  description = "enter ec2 image id"
  type        = string
}
variable "key_name" {}
variable "my_public_ip" {}
variable "instance_type" {}
variable "private_key_location" {}