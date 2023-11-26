data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az1 = var.az1 != null ? var.az1 : data.aws_availability_zones.available.names[0]
  az2 = var.az2 != null ? var.az2 : data.aws_availability_zones.available.names[1]
  az3 = var.az3 != null ? var.az3 : data.aws_availability_zones.available.names[2]
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name   = "ce1"
  public_key = tls_private_key.ssh.public_key_openssh
}

output "ssh_private_key_pem" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}

output "ssh_public_key_pem" {
  value = tls_private_key.ssh.public_key_pem
}

resource "aws_default_security_group" "securitygroup" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "Permit All Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Permit all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "SecurityGroup"
  }
}

resource "aws_instance" "ec2instance" {
  instance_type = "t3.xlarge"
  # centos ami us-east-2 region below
  ami           = "ami-01ba94b5a83adcb35"
  # rhel ami us-east-2 region below
  # ami = "ami-029d17ae8507c9b4a"
  key_name                = aws_key_pair.ssh.key_name
  disable_api_termination = false
  ebs_optimized           = false
  root_block_device {
    volume_size = "80"
    volume_type = "gp3"
  }
  user_data_replace_on_change = true
  user_data = templatefile("~/code/natgateway_test/cloud_init.yaml.template",
    {
      sitetoken     = "${var.sitetoken}",
      clustername   = "${var.clustername}",
      sitelatitude  = "${var.sitelatitude}",
      sitelongitude = "${var.sitelongitude}"
      sitesshrsakey = "${tls_private_key.ssh.private_key_pem}"
    }
  )
  network_interface {
    network_interface_id = aws_network_interface.f5xc_ce1_outside.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.f5xc_ce1_inside.id
    device_index         = 1
  }
  tags = {
    "Name" = "ceaz1"
  }
}

resource "aws_subnet" "securityServicesSubnetInsideAZ1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.SecurityServiceInsideCIDRAZ1
  availability_zone = local.az1
}

resource "aws_subnet" "securityServicesSubnetOutsideAZ1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.SecurityServiceOutsideCIDRAZ1
  availability_zone = local.az1
}

resource "aws_network_interface" "f5xc_ce1_inside" {
  subnet_id                 = aws_subnet.securityServicesSubnetInsideAZ1.id
  private_ips_count         = 1
  source_dest_check         = false
  private_ip_list_enabled   = false
  ipv6_address_list_enabled = false
}

resource "aws_network_interface" "f5xc_ce1_outside" {
  subnet_id                 = aws_subnet.securityServicesSubnetOutsideAZ1.id
  private_ips_count         = 1
  source_dest_check         = false
  private_ip_list_enabled   = false
  ipv6_address_list_enabled = false
}
