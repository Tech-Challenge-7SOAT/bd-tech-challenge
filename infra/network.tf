resource "aws_security_group" "fastfood_db_sg" {
  name        = "fastfood_db_sg"
  vpc_id      = aws_vpc.fastfood_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fastfood_db_sg"
  }
}

resource "aws_security_group_rule" "github_ipv4" {
  for_each          = toset(var.ingress_ipv4_cidr_blocks)
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.fastfood_db_sg.id
}

resource "aws_security_group_rule" "github_ipv6" {
  for_each          = toset(var.ingress_ipv6_cidr_blocks)
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  ipv6_cidr_blocks  = [each.value]
  security_group_id = aws_security_group.fastfood_db_sg.id
}

resource "aws_db_subnet_group" "fastfood_db_subnet_gp" {
  name       = "fastfood-db-sb-gp"
  subnet_ids = [
    aws_subnet.fastfood_db_subnet_az_1.id,
    aws_subnet.fastfood_db_subnet_az_2.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc" "fastfood_vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

    tags = {
        Name = "fastfood_vpc"
    }
}

resource "aws_internet_gateway" "fastfood_igtw" {
  vpc_id = aws_vpc.fastfood_vpc.id

  tags = {
    Name = "fastfood_igtw"
  }
}

resource "aws_route_table" "fastfood_route_tb" {
  vpc_id = aws_vpc.fastfood_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fastfood_igtw.id
  }

  tags = {
    Name = "fastfood_route_tb"
  }
}

resource "aws_subnet" "fastfood_db_subnet_az_1" {
  vpc_id            = aws_vpc.fastfood_vpc.id
  cidr_block        = var.db_subnet_cidr_block_1
  availability_zone = var.SUBNET_AZ_1

  tags = {
    Name = "fastfood_db_subnet_az_1"
  }
}

resource "aws_subnet" "fastfood_db_subnet_az_2" {
  vpc_id            = aws_vpc.fastfood_vpc.id
  cidr_block        = var.db_subnet_cidr_block_2
  availability_zone = var.SUBNET_AZ_2

  tags = {
    Name = "fastfood_db_subnet_az_2"
  }
}

resource "aws_route_table_association" "fastfood_rta_subnet_1" {
  subnet_id      = aws_subnet.fastfood_db_subnet_az_1.id
  route_table_id = aws_route_table.fastfood_route_tb.id
}

resource "aws_route_table_association" "fastfood_rta_subnet_2" {
  subnet_id      = aws_subnet.fastfood_db_subnet_az_2.id
  route_table_id = aws_route_table.fastfood_route_tb.id
}