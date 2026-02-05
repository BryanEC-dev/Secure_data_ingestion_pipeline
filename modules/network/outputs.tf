output "vpc_id_final" {
  value = aws_vpc.vpc_proyect_information.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
  
}