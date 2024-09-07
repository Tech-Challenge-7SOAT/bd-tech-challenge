provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

resource "null_resource" "db_migrations" {
  depends_on = [aws_db_instance.default]

  provisioner "local-exec" {
    command = "mysql -h ${aws_db_instance.default.address} -u ${var.db_username} -p${var.db_password} < db_schema.sql"
  }
}