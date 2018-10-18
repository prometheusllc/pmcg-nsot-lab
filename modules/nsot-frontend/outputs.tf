output "keyname" {
  value = "${aws_key_pair.cosmos-admin.key_name}"
}
output "keypath" {
  value = "${aws_key_pair.cosmos-admin.public_key}"
}
