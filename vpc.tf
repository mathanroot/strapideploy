resource "aws_vpc" "strapi_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.strapi_vpc.id
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.strapi_vpc.id
  cidr_block        = var.public_subnet_cidrs[0]
  map_public_ip_on_launch = true
}


resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.strapi_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-${count.index + 1}"
  }
}
