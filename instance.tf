resource "aws_instance" "example1" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_subnet1_pub.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.pub_example_sg.id]

    user_data = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y net-tools
    EOF

    tags = {
        Name = "example1_pub"
    }
}
resource "aws_instance" "example2" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_subnet2_pri.id
    vpc_security_group_ids = [aws_security_group.pri_example_sg.id]
    
    user_data = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y net-tools
    EOF
    
    tags = {
        Name = "example2_pri"
    }
}