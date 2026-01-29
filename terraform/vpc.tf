resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
    tags = {
        Name = "ecommerce-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
    tags = {
        Name = "ecommerce-igw"
    }
  
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}a"
    tags = {
        Name = "ecommerce-public-subnet"
    }
}

resource "aws_subnet" "Private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "${var.aws_region}a"
    tags = {
        Name = "ecommerce-private-subnet"
    }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
    tags = {
        Name = "ecommerce-public-route-table"
    }
}
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}