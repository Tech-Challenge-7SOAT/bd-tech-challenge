resource "aws_db_instance" "default" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "11.5"
  instance_class       = "db.t3.micro"
  db_name              = var.DB_NAME
  username             = var.DB_USERNAME
  password             = var.DB_PASSWORD
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "null_resource" "db_migrations" {
  depends_on = [aws_db_instance.default]

  provisioner "local-exec" {
    command = "PGPASSWORD=${var.DB_PASSWORD} psql -h ${aws_db_instance.default.address} -U ${var.DB_USERNAME} -d ${var.DB_NAME} -f db_schema.sql"
  }
}