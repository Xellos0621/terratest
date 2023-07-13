output "pub_ip1" {
  value = "${aws_instance.example1.public_ip}"
}
output "pri_ip2" {
  value = "${aws_instance.example2.private_ip}"
}