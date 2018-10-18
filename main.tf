
module "vpc" {
  source = "./modules/vpc"
  name = "NSOT-Frontend"
  cidr = "10.50.0.0/16"
  public_subnet  = "10.50.0.0/24"
  public_subnet2  = "10.50.1.0/24"
  private_subnet  = "10.50.10.0/24"
  private_subnet2  = "10.50.11.0/24"
  region = "us-east-1"
  azone      = "us-east-1a"
  azone2      = "us-east-1b"
 #Tag variables for this module
  responsible-group-email = "ops@ops.com"
  environment = "Test"
}
module "logs" {
  source = "./modules/logs"
  vpc_id =  "${module.vpc.vpc_id}"
  environment  = "cosmos-nsot-prod"
  flow_log_retention_in_days = "5"
}

module "rds" {
source = "./modules/tf_aws_rds-master"
rds_vpc_id = "${module.vpc.vpc_id}"
rds_instance_identifier = "nsottest"
rds_allocated_storage = "20"
rds_engine_type = "mysql"
rds_engine_version  = "5.6.35"
rds_instance_class = "db.t2.medium"
database_name  = "nsot"
database_user = "test"
database_password  = "testtest"
database_port = "3306"
private_cidr = "${module.vpc.cidr}"
subnets  = "${module.vpc.private_subnet}"
subnets2  = "${module.vpc.private_subnet2}"
}

module "nsot" {
  source = "./modules/nsot-frontend"
  vpc_id =  "${module.vpc.vpc_id}"
  elb_id = "${module.elb.elb_id}"
  ami_region1 = "ami-a0e152cf" #"ami-1e339e71"
  instance_type = "t2.small"
  public_subnet  = "${module.vpc.public_subnet}"
  public_subnet2  = "${module.vpc.public_subnet2}"
  private_subnet  = "${module.vpc.private_subnet}"
  private_subnet2  = "${module.vpc.private_subnet2}"
  aws_region1 = "us-east-1"
  azone  = "us-east-1a"
  azone2  = "us-east-1b"
  PATH_TO_PRIVATE_KEY = "~/.ssh/nsot-admin"
  PATH_TO_PUBLIC_KEY = "~/.ssh/nsot-admin.pub"
  RDS_NAME = "nsot"
  RDS_USER = "test"
  RDS_PASS = "testtest"
  RDS_HOST = "${module.rds.rds_instance_address}"
  RDS_PORT = "3306"
  NSOT_EMAIL = "ops@ops.com"
  NSOT_PASS = "testtest"
  #Tag variables for this module
  responsible-group-email = "ops@ops.com"
  environment = "Test"
  


 
}

module "elb" {
  source = "./modules/elb"
  vpc_id =  "${module.vpc.vpc_id}"
  public_subnet  = "${module.vpc.public_subnet}"
  public_subnet2  = "${module.vpc.public_subnet2}"
  DNS = "nsot-test"
}

module "bastion" {
  source = "./modules/bastion"
  vpc_id =  "${module.vpc.vpc_id}"
  name = "cosmos-nsot-bastion"
  ami_region1 = "ami-a0e152cf" #"ami-1e339e71"
  instance_type = "t2.small"
  public_subnet  = "${module.vpc.public_subnet}"
  public_subnet2  = "${module.vpc.public_subnet2}"
  keyname = "${module.nsot.keyname}"
  #Tag variables for this module
   responsible-group-email = "ops@ops.com"
  environment = "Test"
 
}
