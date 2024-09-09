resource "aws_security_group" "fastfood_db_sg" {
  name        = "fastfood_db_sg"
  vpc_id      = vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "fastfood_db_subnet_gp" {
  name       = "fastfood-db-sb-gp"
  subnet_ids = [
    aws_subnet.subnet[0].id,
    aws_subnet.subnet[1].id
  ]
}

resource "aws_db_instance" "default" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  db_name              = var.DB_NAME
  username             = var.DB_USERNAME
  password             = var.DB_PASSWORD
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  publicly_accessible  = false
  db_subnet_group_name   = aws_db_subnet_group.fastfood_db_subnet_gp.name
  vpc_security_group_ids = [aws_security_group.fastfood_db_sg.id]
}

resource "null_resource" "db_migrations" {
  depends_on = [aws_db_instance.default]

  provisioner "local-exec" {
    command = "PGPASSWORD=${var.DB_PASSWORD} psql -h ${aws_db_instance.default.address} -U ${var.DB_USERNAME} -d ${var.DB_NAME} -f db_schema.sql"
  }
}