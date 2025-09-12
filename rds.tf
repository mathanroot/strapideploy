resource "aws_db_instance" "strapi_db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.14"
  instance_class       = "db.t3.micro"
  
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
}




data "aws_availability_zones" "available" {}
resource "aws_db_subnet_group" "rds_subnet" {
  name       = "strapi-rds-subnet"
  subnet_ids = aws_subnet.private[*].id
}

