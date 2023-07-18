output "pub_ip1" {
  value = "${aws_instance.example1.public_ip}"
}

output "pri_ip2" {
  value = "${aws_instance.example2.private_ip}"
}

output "public_instance_ssh_command" {
  value = "ssh -i mykey.pem ec2-user@${aws_instance.example1.public_ip}"
}

output "private_instance_ssh_command" {
  value = "ssh -i mykey.pem ec2-user@${aws_instance.example2.public_ip} ssh -i mykey.pem ec2-user@${aws_instance.example2.private_ip}"
}

output "nat_eip_public_ip" {
  value = aws_eip.nat_eip.public_ip
}