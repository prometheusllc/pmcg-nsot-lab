
variable "elb_id" {
    description = "elb id passed from elb module used in asg"
    default = ""
}

variable "aws_region1" {
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
variable "azone2" {
    description = "EC2 az1 for the VPC"
    default = ""
}
variable "vpc_id" {
    description = "VPC id for NSOT frontend"
    default = ""
}
variable "DNS" {
    description = "DNS a record pointing to nsot elb"
    default = ""
}
variable "instance_type" {
    description = "instance size for nsot ec2 instance"
    default = ""
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
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "vpc_cidr_region1" {
    description = "CIDR for the whole VPC"
    default = ""
}

variable "public_subnet" {
    description = "nsot-app-server Eth0 Net"
    default = ""
}
variable "public_subnet2" {
    description = "nsot-app-server Eth0 Net"
    default = ""
}
variable "private_subnet" {
    description = "nsot-app-server Eth0 Net"
    default = ""
}
variable "private_subnet2" {
    description = "nsot-app-server Eth0 Net"
    default = ""
}
variable "RDS_NAME" {
    description = "Name Given to RDS Instance"
    default = ""
}
variable "RDS_USER" {
    description = "UserName Given to RDS Instance"
    default = ""
}
variable "RDS_PASS" {
    description = "Password Given to RDS Instance"
    default = ""
}
variable "RDS_HOST" {
    description = "DNS/Hostname Given to RDS Instance"
    default = ""
}
variable "RDS_PORT" {
    description = "Port Used to access RDS Instance"
    default = ""
}
variable "NSOT_EMAIL" {
    description = "This will be used as your NSOT Username"
    default = ""
}
variable "NSOT_PASS" {
    description = "This will be used as your NSOT Password"
    default = ""
}
variable "requirensot" {
  default = "2"
}
#The variables below are used for tagging all of the resources within this module.
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
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
 
