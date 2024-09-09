resource "aws_vpc" "fastfood_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "subnet" {
  count             = length(var.subnet)
  vpc_id            = aws_vpc.fastfood_vpc.id
  cidr_block        = var.subnet[count.index].cidr_block
  availability_zone = var.subnet[count.index].availability_zone

  tags = {
    Name = var.subnet[count.index].name
  }
}