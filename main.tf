resource "aws_vpc" "vpc"{
    cidr_block="10.0.0.0/16"
    enable_dns_support   = true
  enable_dns_hostnames = true


}

resource "aws_internet_gateway" "igw1"{
    vpc_id=aws_vpc.vpc.id

}

resource "aws_subnet" "pub_sub1"{
    vpc_id=aws_vpc.vpc.id
    cidr_block="10.0.1.0/24"
    availability_zone="us-east-1a"

    tags={
        Name="pub_subnet"
    }

}



resource "aws_subnet" "pri_sub1"{
    vpc_id=aws_vpc.vpc.id
    cidr_block="10.0.2.0/24"

    tags={
        Name="pri_subnet"
    }
}
resource "aws_subnet" "pri_sub2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_route_table" "pub_rt1_ex"{
    vpc_id=aws_vpc.vpc.id

    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw1.id
    }

}
resource "aws_route_table" "pri_rt1_ex"{
    vpc_id=aws_vpc.vpc.id

}

#subnet association

resource "aws_route_table_association" "pubsub1_rt"{
    subnet_id=aws_subnet.pub_sub1.id
    route_table_id=aws_route_table.pub_rt1_ex.id

}

resource "aws_route_table_association" "prisub1_rt"{
    subnet_id=aws_subnet.pri_sub1.id
    route_table_id=aws_route_table.pri_rt1_ex.id

}



resource "aws_security_group" "sg1"{
    name="ex_vpc_sg1"
    vpc_id=aws_vpc.vpc.id

    ingress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=[aws_vpc.vpc.cidr_block]
    }

    ingress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
      ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
    ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Strapi (1337)"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    

    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]

    }


}


resource "aws_eip" "nat_eip" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub_sub1.id

  tags = {
    Name = "my-nat-gateway"
  }
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}



resource "aws_instance" "web" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.pub_sub1.id
  key_name               = "dock"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg1.id]

  # Add bigger root volume (20GB)
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

 # Install Node.js, create swap, install & run Strapi
  user_data = <<-EOF
#!/bin/bash
set -e

# Update & install dependencies
apt-get update -y
apt-get install -y curl build-essential git

# Install Node.js 20 + npm
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Enable 2GB swap (to avoid out-of-memory during build)
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab


# Create Strapi project 
npx create-strapi-app@latest strapi-app --quickstart --no-run 


# Build Strapi admin panel
cd strapi-app
npm run develop

EOF


  tags = {
    Name = "Terraform deploy"
  }
}



resource "aws_instance" "db"{
    ami  = "ami-0e86e20dae9224db8"
    instance_type ="t2.micro"
    subnet_id=aws_subnet.pri_sub1.id
    key_name="dock"
    
    vpc_security_group_ids=[aws_security_group.sg1.id]

    tags={
        Name="Terraform deploy"
    }

}




