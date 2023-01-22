terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  region = var.vpc_vars.region
  # access_key = "${var.aws_access_key}"
  # secret_key = "${var.aws_secret_key}"
}

#Create the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_vars.cidr
  enable_dns_hostnames = true
}

# Define the public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_vars.subnet
  availability_zone = var.vpc_vars.az
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

# Define the public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc_vars.rt_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
}
# Assign the public route table to the public subnet
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

data "aws_ami" "rhel_ami" {
  most_recent      = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["RHEL-9*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "nodes" {
  for_each      = var.instances
  instance_type = each.value.instance_type
  ami           = each.value.ami
  key_name      = each.value.key_name

  tags = {
    Name = each.key
  }
}

##########################################

# provisioner "remote-exec" {
#   inline = [
#     "sudo yum -y update",
#     "sudo yum -y install apache",
#     "sudo systemctl start apache",
#     "sudo chown -R rhel:rhel /var/www/html",
#     "chmod +x *.sh",
#   ]

#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = tls_private_key.hashicat.private_key_pem
#     host        = aws_eip.hashicat.public_ip
#   }
# }

# provisioner "local-exec" {
#   command = "ansible-playbook -i '${aws_eip.hashicat.public_ip},' --private-key ${tls_private_key.hashicat.private_key_pem} ../ansible/httpd.yml"
# }