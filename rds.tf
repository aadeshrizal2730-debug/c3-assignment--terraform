resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}
resource "aws_db_instance" "main" {
  identifier           = "ha-db"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = "dbadmin"
  password             = aws_ssm_parameter.db_password.value
  multi_az             = true
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot  = true
}

