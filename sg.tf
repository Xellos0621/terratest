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

  ingress {#편의에 의하여
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {#편의에 의하여
    from_port = 0
    to_port = 0
    protocol = "-1"
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

  ingress {#편의에 의하여
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {#편의에 의하여
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 기타 필요한 인바운드 및 아웃바운드 규칙 설정
}

resource "aws_security_group" "example_db_sg" {
  name_prefix = "example-db-sg"
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 원하는 IP 범위를 입력하여 RDS에 접근을 허용합니다.
  }
}