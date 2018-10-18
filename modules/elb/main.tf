resource "random_id" "sshkey2" {
  byte_length = 8
}

resource "aws_security_group" "cosmos-NSOT_ELB" {
    name = "cosmos-nsot-sg-${random_id.sshkey2.hex}"
    description = "Allow incoming traffic"

    ingress {
        from_port = 80
        to_port = 80
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
        Name = "cosmos-nsot-SG"
        environment = "cosmos-test"
    }
}


# Create a new load balancer
resource "aws_elb" "cosmos-NSOT" {
 
name  = "cosmos-NSOT-prod-elb" 
 subnets = ["${var.public_subnet}","${var.public_subnet2}"]
 security_groups = ["${aws_security_group.cosmos-NSOT_ELB.id}"]
  cross_zone_load_balancing  = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400
  listener {
    instance_port     = 8990
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8990/"
    interval            = 30
  }

  tags {
    Name = "cosmos-nsot-elb-tf"
  }
}

resource "aws_route53_record" "www" {
  zone_id = "ZJUW1FLH7BIEB"
  name    = "${var.DNS}"
  type    = "A"

  alias {
    name                   = "${aws_elb.cosmos-NSOT.dns_name}"
    zone_id                = "${aws_elb.cosmos-NSOT.zone_id}"
    evaluate_target_health = true
  }
}


