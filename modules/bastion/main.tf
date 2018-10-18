
  # Template for initial config of frontend nsot servers
data "template_file" "init" {
  template = "${file("bastion-init.tpl")}"
}

resource "random_id" "sshkey" {
  byte_length = 8
}

resource "aws_security_group" "NSOT_region1" {
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
    value               = "NSOT-Bastion-${random_id.sshkey.hex}-SG"
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
/*
resource "aws_key_pair" "cosmos-admin" {
  key_name = "nsot-admin-${random_id.sshkey.hex}"
  public_key = "~/.ssh.nsot-admin.pub" #"${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
*/
resource "aws_launch_configuration" "bastion" {
  image_id                    = "${var.ami_region1}"
  name_prefix                 = "bastion-"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "${var.keyname}"
  security_groups             = ["${aws_security_group.nsot-NSOT_region1.id}"]
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

resource "aws_autoscaling_group" "bastion" {
  vpc_zone_identifier       = ["${var.public_subnet}, ${var.public_subnet2}"]
  name                      = "bastion-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.bastion.name}"
  termination_policies      = ["OldestInstance"]
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "NSOT-bastion-mgt-server"
    propagate_at_launch = true
  }
  tag {
    key                 = "t_cost_centre"
    value               = "${var.cost_centre}"
    propagate_at_launch = true
  }
  tag {
    key                 = "t_owner_individual"
    value               = "${var.owner_individual}"
    propagate_at_launch = true
  }
  tag {
    key                 = "t_responsible_individuals"
    value               = "${var.responsible-group-email}"
    propagate_at_launch = true
  }
  tag {
    key                 = "t_role"
    value               = "${var.role}"
    propagate_at_launch = true
  }
  tag {
    key                 = "t_environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

}



