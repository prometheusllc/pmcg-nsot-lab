
variable "vpc_id" {
    description = "ID for NSOT VPC"
    default = ""
}

variable "public_subnet" {
    description = "ELB public subnet1"
    default = ""
}
variable "public_subnet2" {
    description = "ELB public subnet2"
    default = ""
}
variable "DNS" {
    description = "DNS arecord pointing to elb"
    default = ""
}