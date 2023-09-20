output "vpc_id" {
  value = aws_vpc.TVPC.id
}

output "vpc_cidr" {
  value = aws_vpc.TVPC.cidr_block
}

output "vpc_public_subnets" {
  value = aws_subnet.public.*.id
}

output "vpc_private_subnets" {
  value = aws_subnet.private.*.id
}

output "vpc_db_private_subnets" {
  value = aws_subnet.db_private.*.id
}

output "vpc_public_rt" {
  value = aws_route_table.public.id
}

output "vpc_private_rt" {
  value = aws_route_table.private.id
}

output "vpc_db_private_rt" {
  value = aws_route_table.db_private.id
}