output "db_subnet_id_az_1" {
  value       = aws_subnet.subnet[0].id
  description = "Subnet Id of the first availability zone (AZs-1)"
}

output "db_subnet_id_az_2" {
  value       = aws_subnet.subnet[1].id
  description = "Subnet Id of the second availability zone (AZs-2)"
}

output "vpc_id" {
  value       = "${aws_vpc.fastfood_vpc.id}"
  description = "VPC id"
}

