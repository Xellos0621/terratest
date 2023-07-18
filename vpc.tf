resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  # 기타 필요한 구성 옵션을 추가합니다.
}

resource "aws_subnet" "subnet1_pub" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  # 기타 필요한 구성 옵션을 추가합니다.
}
resource "aws_subnet" "subnet2_pri" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"
  # 기타 필요한 구성 옵션을 추가합니다.
}
resource "aws_subnet" "subnet3_pri" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2a"
}
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.my_vpc.id
}
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gateway.id
  }
}
resource "aws_route_table" "pri_nat_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pri_nat_gateway.id
  }
}
resource "aws_route_table_association" "my_subnet1_association" {
  subnet_id      = aws_subnet.subnet1_pub.id
  route_table_id = aws_route_table.my_route_table.id
}
resource "aws_route_table_association" "my_subnet2_association" {
  subnet_id      = aws_subnet.subnet2_pri.id
  route_table_id = aws_route_table.pri_nat_route_table.id
}

resource "aws_nat_gateway" "pri_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.subnet2_pri.id
  depends_on = [aws_internet_gateway.main_gateway]
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}