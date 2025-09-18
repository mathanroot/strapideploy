resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow PostgreSQL only from EC2 SG"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Postgres from EC2 SG"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.sg1.id] # Only allow from EC2 SG
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
resource "aws_db_instance" "strapi_rds" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t3.micro"
  
  username             = "strapiuser"
  password             = "StrongPassword123!"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.sg1.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
}



resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "strapi-rds-subnet"
  subnet_ids = [aws_subnet.pri_sub1.id,
  aws_subnet.pri_sub2.id] 
  tags = { Name = "strapi-rds-subnet" }
}

