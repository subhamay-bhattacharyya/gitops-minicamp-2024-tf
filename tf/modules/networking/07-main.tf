## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- networking/main.tf ---

# --- Random Shuffle
resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnet_count
}

# --- VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge({
    Name = "${var.project_name}-vpc${var.ci_build}"
  }, local.tags)

  lifecycle {
    create_before_destroy = true
  }
}

# --- Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${var.project_name}-igw${var.ci_build}"
  }, local.tags)
}

# --- Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "${var.project_name}-rt${var.ci_build}"
  }, local.tags)
}

# -- Public Subnet
resource "aws_subnet" "public_subnet" {
  count                   = var.max_subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]

  lifecycle {
    create_before_destroy = true
  }
  tags = merge({
    Name = "public subnet az-${count.index + 1}${var.ci_build}"
  }, local.tags)
}


# -- Route Table Association
resource "aws_route_table_association" "route_table_association" {
  count          = var.max_subnet_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
}

#-- Security Group
resource "aws_security_group" "security_group" {
  name        = "${var.project_name}-sg"
  description = "Allow port 3000"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.project_name}-sg${var.ci_build}"
  }, local.tags)
}