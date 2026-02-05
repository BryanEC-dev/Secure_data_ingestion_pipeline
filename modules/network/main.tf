# crear vpc 
resource "aws_vpc" "vpc_proyect_information" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.network_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_proyect_information.id
  cidr_block        = var.subnet_private_cidr
  tags = {
    Name = var.subnet-private-name
  }
  
}