terraform {

  required_version = ">= 1.5.0"

  required_providers {

    aws = {

      source  = "hashicorp/aws"

      version = "~> 5.0"
    }
  }
}

provider "aws" {

  region = var.aws_region
}

# =========================================================
# VPC
# =========================================================

resource "aws_vpc" "edtech_vpc" {

  cidr_block = "10.0.0.0/16"

  enable_dns_support = true

  enable_dns_hostnames = true

  tags = {

    Name = "edtech-vpc"
  }
}

# =========================================================
# Public Subnet
# =========================================================

resource "aws_subnet" "public_subnet" {

  vpc_id = aws_vpc.edtech_vpc.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "${var.aws_region}a"

  map_public_ip_on_launch = true

  tags = {

    Name = "edtech-public-subnet"
  }
}

# =========================================================
# Internet Gateway
# =========================================================

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.edtech_vpc.id

  tags = {

    Name = "edtech-igw"
  }
}

# =========================================================
# Route Table
# =========================================================

resource "aws_route_table" "public_route_table" {

  vpc_id = aws_vpc.edtech_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {

    Name = "edtech-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {

  subnet_id = aws_subnet.public_subnet.id

  route_table_id = aws_route_table.public_route_table.id
}

# =========================================================
# Security Group
# =========================================================

resource "aws_security_group" "edtech_sg" {

  name = "edtech-security-group"

  description = "Allow HTTP SSH"

  vpc_id = aws_vpc.edtech_vpc.id

  ingress {

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port = 5173

    to_port = 5173

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port = 8000

    to_port = 8000

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {

    Name = "edtech-security-group"
  }
}

# =========================================================
# EC2 Instance
# =========================================================

resource "aws_instance" "edtech_server" {

  ami = var.ec2_ami

  instance_type = var.instance_type

  subnet_id = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.edtech_sg.id
  ]

  associate_public_ip_address = true

  key_name = var.key_pair_name

  tags = {

    Name = "edtech-platform-server"
  }
}

# =========================================================
# Output
# =========================================================

output "server_public_ip" {

  value = aws_instance.edtech_server.public_ip
}
