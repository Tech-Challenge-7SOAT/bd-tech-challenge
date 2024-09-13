resource "aws_db_instance" "default" {
  identifier           = "fastfoodrds"
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
  publicly_accessible  = true
  db_subnet_group_name   = aws_db_subnet_group.fastfood_db_subnet_gp.name
  vpc_security_group_ids = [aws_security_group.fastfood_db_sg.id]

  tags = {
    Name = "fastfood_db_instance"
  }
}

resource "null_resource" "db_migrations" {
  depends_on = [aws_db_instance.default]

  provisioner "local-exec" {
    command = "sleep 60; psql -U ${var.DB_USERNAME} -d ${var.DB_NAME} -h ${aws_db_instance.default.address} -v passwd=${var.DB_PASSWORD} -f ./db_schema.sql"
  }
}