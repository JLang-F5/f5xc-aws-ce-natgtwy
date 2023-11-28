output "nat_gateway_ip" {
  value = aws_eip.nat_gateway.public_ip
}

output "aws_subnet" {
  value = aws_subnet.securityServicesSubnetOutsideAZ1.id
}


output "aws_vpc" {
  value = aws_vpc.vpc.id
}

output "aws_default_security_group" {
  value = aws_default_security_group.securitygroup.id
}
