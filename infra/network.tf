resource "aws_security_group" "fastfood_db_sg" {
  name        = "fastfood_db_sg"
  vpc_id      = aws_vpc.fastfood_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

    tags = {
        Name = "fastfood_vpc"
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