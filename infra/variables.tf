variable "DB_NAME" {
  description = "The name of the database"
  type        = string
}

variable "DB_USERNAME" {
    description = "The username for the database"
    type        = string
}

variable "DB_PASSWORD" {
    description = "The password for the database"
    type        = string
    sensitive   = true
}

variable "AWS_ACCESS_KEY_ID" {
  description = "The AWS access key"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The AWS secret access"
  type        = string
  sensitive   = true
}

variable "AWS_SESSION_TOKEN" {
  description = "The AWS session token"
  type        = string
  sensitive   = true
}

variable "AWS_REGION" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "cidr block for VPC"
  type        = string
}

variable "db_subnet_cidr_block_1" {
  description = "cidr block for db subnet"
  type        = string
}

variable "db_subnet_cidr_block_2" {
  description = "cidr block for db subnet"
  type        = string
}

variable "subnet_az_1" {
  description = "First availability zone for the subnet (AZs-1)"
  type        = string
}

variable "subnet_az_2" {
  description = "Second availability zone for the subnet (AZs-2)"
  type        = string
}