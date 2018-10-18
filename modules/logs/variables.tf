
variable "vpc_id" {
    description = "ID for NSOT VPC"
    default = ""
}

variable "environment" {
    description = "name of environment"
    default = ""
}

variable "flow_log_retention_in_days" {
    description = "flow log rentention in days"
    default = ""
}
