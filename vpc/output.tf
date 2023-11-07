# VPC id
output "vpc-id" {
  value = aws_vpc.vpc.id
}

# Subnets ids
output "public-subnet-01-id" {
  value = aws_subnet.subnets["public-subnet-01"].id
}

output "public-subnet-02-id" {
  value = aws_subnet.subnets["public-subnet-02"].id
}

output "application-subnet-01-id" {
  value = aws_subnet.subnets["application-subnet-01"].id
}

output "application-subnet-02-id" {
  value = aws_subnet.subnets["application-subnet-02"].id
}

output "database-subnet-01-id" {
  value = aws_subnet.subnets["database-subnet-01"].id
}

output "database-subnet-02-id" {
  value = aws_subnet.subnets["database-subnet-02"].id
}