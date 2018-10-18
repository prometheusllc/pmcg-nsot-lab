resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-VPC"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "NSOT-${var.environment}-VPC"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"
 tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-IGW"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "used for public facing Bastion Host, NGWs, and ELB"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.mod.id}"
tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-Public-RT"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "used for public facing Bastion Host, NGWs, and ELB"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}
resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.mod.id}"
  tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-Private-RT1"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "used for Isolating NSOT APP/DB servers from inbound Inet Access"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}
resource "aws_route_table" "private2" {
  vpc_id           = "${aws_vpc.mod.id}"
    tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-Private-RT2"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "used for Isolating NSOT APP/DB servers from inbound Inet Access"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mod.id}"
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.public_subnet}"
  availability_zone = "${var.azone}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
  tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-${var.azone}-PublicSubnet1"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "Public facing subnet1 for ELB, Bastion Host in ${var.azone}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

}
resource "aws_subnet" "public2" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.public_subnet2}"
  availability_zone = "${var.azone2}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
  tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-${var.azone}-PublicSubnet2"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "Public facing subnet2 for ELB, Bastion Host in ${var.azone2}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.private_subnet}"
  availability_zone = "${var.azone}"
  map_public_ip_on_launch = "false"
  tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-${var.azone}-PrivateSubnet1"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "Private Subnet1 for NSOT APP servers, RDS cluster in ${var.azone}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

}
resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.private_subnet2}"
  availability_zone = "${var.azone2}"
  map_public_ip_on_launch = "false"
    tags {
    key                 = "Name"
    value               = "NSOT-${var.environment}-${var.azone}-PrivateSubnet2"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "Private Subnet2 for NSOT APP servers, RDS cluster in ${var.azone2}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

resource "aws_eip" "nat1" {
    vpc      = true
}
resource "aws_eip" "nat2" {
    vpc      = true
}
resource "aws_nat_gateway" "public" {
    allocation_id = "${aws_eip.nat1.id}"
    subnet_id = "${aws_subnet.public.id}"
    depends_on = ["aws_internet_gateway.mod"]
}
resource "aws_nat_gateway" "public2" {
    allocation_id = "${aws_eip.nat2.id}"
    subnet_id = "${aws_subnet.public2.id}"
    depends_on = ["aws_internet_gateway.mod"]
}


resource "aws_route_table_association" "public" {
  count          =  "1" #"${length(var.public_subnet)}"
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "public2" {
  count          =  "1" #"${length(var.public_subnet)}"
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "private" {
  count          =  "1" #"${length(var.public_subnet)}"
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "private2" {
  count          =  "1" #"${length(var.public_subnet)}"
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.private2.id}"
}

# add a nat gateway to each private subnet's route table
resource "aws_route" "private_nat_gateway_route1" {
  route_table_id = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.private"]
  nat_gateway_id = "${aws_nat_gateway.public.id}"
}
resource "aws_route" "private_nat_gateway_route2" {
  route_table_id = "${aws_route_table.private2.id}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.private2"]
  nat_gateway_id = "${aws_nat_gateway.public2.id}"
}
