resource "aws_db_subnet_group" "example_db_subnet_group" {
  name       = "example-db-subnet-group"
  subnet_ids = [aws_subnet.subnet3_pri.id]  # RDS를 생성할 서브넷 ID를 입력합니다.
}

resource "aws_db_instance" "sql_rds" {
  identifier             = "sql-rds"
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.example_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.example_db_sg.id]
  username               = "admin"
  password               = "your_password_here"  # 원하는 비밀번호를 입력합니다.
}
