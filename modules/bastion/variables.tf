

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = ""
}
variable "name" {
    description = "EC2 name"
    default = ""
}
variable "azone" {
    description = "EC2 az1 for the VPC"
    default = ""
}

variable "vpc_id" {
    description = "VPC id for NSOT frontend"
    default = ""
}

variable "instance_type" {
    description = "instance size for nsot ec2 instance"
    default = ""
}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "ami_region1" {
    description = "AMIs by region"
    default = "" # Use ubuntu 16.04 LTS AMI
}

variable "PATH_TO_PRIVATE_KEY" {
  default = ""
}
variable "PATH_TO_PUBLIC_KEY" {
  default = ""
}

variable "keyname" {
    description = "shared ssh keyname"
    default = "" 
}
variable "keypath" {
    description = "shared ssh keyname"
    default = "" 
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "public_subnet" {
    description = "nsot-bastion-server1 Eth0 Net"
    default = ""
}
variable "public_subnet2" {
    description = "nsot-bastion-server2 Eth0 Net"
    default = ""
}
/*
variable "elb_id" {
    description = "elb id passed from elb module used in asg"
    default = ""
}
*/
variable "cost_centre" {
  default = ""
}
variable "responsible-group-email" {
  default = ""
}
variable "owner_individual" {
  default = ""
}
variable "role" {
  default = ""
}
variable "environment" {
  default = ""
}