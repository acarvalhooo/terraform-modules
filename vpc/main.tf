# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = var.dns-support
  enable_dns_hostnames = var.dns-support

  tags = {
    Name        = "vpc-${var.environment}"
    Environment = var.environment
  }
}

# Creating public and private subnets
resource "aws_subnet" "subnets" {
  for_each = {
    "public-subnet-01"      = { cidr_block = "192.168.0.0/24", availability_zone = var.az-1, map_public_ip_on_launch = var.map-public-ip }
    "public-subnet-02"      = { cidr_block = "192.168.1.0/24", availability_zone = var.az-2, map_public_ip_on_launch = var.map-public-ip }
    "application-subnet-01" = { cidr_block = "192.168.2.0/24", availability_zone = var.az-1 }
    "application-subnet-02" = { cidr_block = "192.168.3.0/24", availability_zone = var.az-2 }
    "database-subnet-01"    = { cidr_block = "192.168.4.0/24", availability_zone = var.az-1 }
    "database-subnet-02"    = { cidr_block = "192.168.5.0/24", availability_zone = var.az-2 }
  }

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name        = "${each.key}-${var.environment}-${each.value.availability_zone}"
    Environment = var.environment
  }
}

# Creating internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "igw-${var.environment}"
    Environment = var.environment
  }
}

# Creating elastic ips
resource "aws_eip" "eip" {
  for_each = {
    "eip-01" = {}
    "eip-02" = {}
  }

  domain = "vpc"

  tags = {
    Name        = "${each.key}-${var.environment}-${local.elastic_ips_association[each.key]}"
    Environment = var.environment
  }
}

# Creating nat gateways
resource "aws_nat_gateway" "ngw" {
  for_each = {
    "ngw-01" = { subnet_id = aws_subnet.subnets["public-subnet-01"].id, allocation_id = aws_eip.eip["eip-01"].id }
    "ngw-02" = { subnet_id = aws_subnet.subnets["public-subnet-02"].id, allocation_id = aws_eip.eip["eip-02"].id }
  }

  subnet_id     = each.value.subnet_id
  allocation_id = each.value.allocation_id

  tags = {
    Name        = "${each.key}-${var.environment}-${local.nat_gateway_availability_zones[each.key]}"
    Environment = var.environment
  }
}

# Creating public route table and associating to subnets
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.internet-cidr-block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "public-route-table-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public-association" {
  for_each = {
    "public-association-01" = { subnet_id = aws_subnet.subnets["public-subnet-01"].id }
    "public-association-02" = { subnet_id = aws_subnet.subnets["public-subnet-02"].id }
  }

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.public-route-table.id
}

# Creating private route table and association for availability zone 01
resource "aws_route_table" "private-route-table-az-1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.internet-cidr-block
    nat_gateway_id = aws_nat_gateway.ngw["ngw-01"].id
  }

  tags = {
    Name        = "private-route-table-${var.environment}-${var.az-1}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private-association-az-1" {
  for_each = {
    "private-association-01" = { subnet_id = aws_subnet.subnets["application-subnet-01"].id }
    "private-association-02" = { subnet_id = aws_subnet.subnets["database-subnet-01"].id }
  }

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.private-route-table-az-1.id
}

# Creating private route table and association for availability zone 02
resource "aws_route_table" "private-route-table-az-2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.internet-cidr-block
    nat_gateway_id = aws_nat_gateway.ngw["ngw-02"].id
  }

  tags = {
    Name        = "private-route-table-${var.environment}-${var.az-2}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private-association-az-2" {
  for_each = {
    "private-association-01" = { subnet_id = aws_subnet.subnets["application-subnet-02"].id }
    "private-association-02" = { subnet_id = aws_subnet.subnets["database-subnet-02"].id }
  }

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.private-route-table-az-2.id
}
