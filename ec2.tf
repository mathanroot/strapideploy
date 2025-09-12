resource "aws_instance" "strapi_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  tags = {
    Name = "Strapi-EC2"
  }
}
