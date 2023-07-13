resource "aws_security_group" "pub_example_sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "pub_example-sg"
  description = "pub_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 기타 필요한 인바운드 및 아웃바운드 규칙 설정
}

resource "aws_security_group" "pri_example_sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "pri_example-sg"
  description = "pri_sg"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.pub_example_sg.id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 기타 필요한 인바운드 및 아웃바운드 규칙 설정
}