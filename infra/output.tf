output "db_subnet_id_az_1" {
  value       = aws_subnet.fastfood_db_subnet_az_1.id
  description = "Subnet Id of the first availability zone (AZs-1)"
}

output "db_subnet_id_az_2" {
  value       = aws_subnet.fastfood_db_subnet_az_2.id
  description = "Subnet Id of the second availability zone (AZs-2)"
}

output "vpc_id" {
  value       = "${aws_vpc.fastfood_vpc.id}"
  description = "VPC id"
}

output "github_ips" {
  value = data.github_ip_ranges.github.hooks
}

