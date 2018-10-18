output "elb_id" {
  value = "${aws_elb.cosmos-NSOT.id}"
}

output "NSOT-ELB-DNS" {
    value = "${aws_elb.cosmos-NSOT.dns_name}"
}