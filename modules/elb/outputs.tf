output "elb_id" {
  value = "${aws_elb.NSOT.id}"
}

output "NSOT-ELB-DNS" {
    value = "${aws_elb.NSOT.dns_name}"
}