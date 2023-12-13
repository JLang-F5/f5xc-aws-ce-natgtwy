output "aws_nat_gateway" {
  value = aws_nat_gateway.nat_gateway.id
}


output "nat_gateway_ip" {
  value = aws_eip.nat_gateway.public_ip
}

output "aws_vpc" {
  value = aws_vpc.vpc.id
}

output "aws_subnet" {
  value = aws_subnet.securityServicesSubnetOutsideAZ1.id
}

output "SecurityServiceInsideCIDRAZ1" {
  value = aws_subnet.securityServicesSubnetInsideAZ1.id
}

output "SecurityServiceOutsideCIDRAZ1" {
  value = aws_subnet.securityServicesSubnetOutsideAZ1.id
}

output "SecurityServiceWorlkoadCIDRAZ1" {
  value = aws_subnet.securityServicesSubnetWorkloadAZ1.id
}

output "aws_default_security_group" {
  value = aws_default_security_group.securitygroup.id
}
