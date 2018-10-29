# Template for initial config of frontend nsot servers
data "template_file" "init" {
  template = "${file("init.tpl")}"

  vars {
    RDS_NAME = "${var.RDS_NAME}"
    RDS_USER = "${var.RDS_USER}"
    RDS_PASS = "${var.RDS_PASS}" 
    RDS_HOST = "${var.RDS_HOST}" 
    RDS_PORT = "${var.RDS_PORT}" 
    NSOT_EMAIL = "${var.NSOT_EMAIL}" 
    NSOT_PASS = "${var.NSOT_PASS}"
  }
}

resource "random_id" "sshkey" {
  byte_length = 8
}

resource "aws_security_group" "cosmos-NSOT_region1" {
    #name = "nsot-sg-${random_id.sshkey.hex}"
    description = "Allow incoming traffic"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["10.0.0.0/8"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8"]
    }
    ingress {
        from_port = 8990
        to_port = 8990
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress { # allow all outbound
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }


    vpc_id = "${var.vpc_id}"

  tags {
    key                 = "Name"
    value               = "NSOT-Frontend-${random_id.sshkey.hex}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_role"
    value               = "IP Address Management (NSOT) Frontend"
    propagate_at_launch = true
  }
  tags {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
    
}
resource "aws_key_pair" "cosmos-admin" {
  key_name = "nsot-admin-${random_id.sshkey.hex}"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_launch_configuration" "nsot" {
  image_id                    = "${var.ami_region1}"
  name_prefix                 = "nsot-"
  instance_type               = "t2.small"
  associate_public_ip_address = false
  key_name                    = "${aws_key_pair.cosmos-admin.key_name}"
  security_groups             = ["${aws_security_group.cosmos-NSOT_region1.id}"]
  user_data                   = "${data.template_file.init.rendered}"
  placement_tenancy           = "default"

  lifecycle {
    create_before_destroy = true
  }

  connection {
      user = "${var.INSTANCE_USERNAME}"
      private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }

}

resource "aws_autoscaling_group" "nsot" {
  vpc_zone_identifier       = ["${var.private_subnet}, ${var.private_subnet2}"]
  name                      = "nsot-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.nsot.name}"
  load_balancers            = ["${var.elb_id}"] 
  termination_policies      = ["OldestInstance"]
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "NSOT-Frontend-App-Server"
    propagate_at_launch = true
  }
  
  tag {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

}



