# VPC definition
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Terraform = "true"
    Name      = "Main-VPC"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Terraform = "true"
    Name      = "Internet-Gateway"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Terraform = "true"
    Name      = "NAT-Gateway-elastic-IP"
  }
}
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  depends_on    = [aws_internet_gateway.main]
  tags = {
    Terraform = "true"
    Name      = "NAT-Gateway"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Terraform = "true"
    Name      = "Public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Terraform = "true"
    Name      = "Private-subnet"
  }
}

resource "aws_route_table" "public_default" {
  vpc_id = aws_vpc.main.id
  tags = {
    Terraform = "true"
    Name      = "Public-route-table"
  }
}

resource "aws_route_table" "private_default" {
  vpc_id = aws_vpc.main.id
  tags = {
    Terraform = "true"
    Name      = "Private-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public_default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private_default.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_default.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_default.id
}

