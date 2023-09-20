resource "aws_vpc" "TVPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-${var.env}-vpc"
    Provisoning = "terraform"
  }
}

# Public subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.TVPC.id
  cidr_block        = var.public_subnet_cidr_blocks["zone${count.index}"]
  availability_zone = "${var.region}${element(var.zones, count.index)}"
  count             = length(var.zones)

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-subnet-${var.env}-public-${count.index}"
    Type        = "${var.DMK}-subnet-${var.env}-public"
    Provisoning = "terraform"
  }
}

# Private subnets
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.TVPC.id
  cidr_block        = var.private_subnet_cidr_blocks["zone${count.index}"]
  availability_zone = "${var.region}${element(var.zones, count.index)}"
  count             = length(var.zones)

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-subnet-${var.env}-private-${count.index}"
    Type        = "${var.DMK}-subnet-${var.env}-private"
    Provisoning = "terraform"
  }
}

# DB Private Subnets
resource "aws_subnet" "db_private" {
  vpc_id            = aws_vpc.TVPC.id
  cidr_block        = var.db_private_subnet_cidr_blocks["zone${count.index}"]
  availability_zone = "${var.region}${element(var.zones, count.index)}"
  count             = length(var.zones)

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-subnet-${var.env}-private-db-${count.index}"
    Type        = "${var.DMK}-subnet-${var.env}-private-db"
    Provisoning = "terraform"
  }
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.TVPC.id

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-${var.env}-public-rt"
    Provisoning = "terraform"
  }
}

# Private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.TVPC.id

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-${var.env}-private-rt"
    Provisoning = "terraform"
  }
}

# DB Private route table
resource "aws_route_table" "db_private" {
  vpc_id = aws_vpc.TVPC.id

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-${var.env}-private-db-rt"
    Provisoning = "terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.TVPC.id
  tags = {
    Name        = "${var.DMK}-${var.env}-igw"
    Environment = var.env
    Provisoning = "terraform"
  }
}

resource "aws_eip" "natgw" {
  domain = "vpc"
  tags = {
    Name        = "${var.DMK}-${var.env}-natgw-eip"
    Environment = var.env
    Provisoning = "terraform"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw.id
  subnet_id     = element(aws_subnet.public.*.id, 0)

  tags = {
    Environment = var.env
    Name        = "${var.DMK}-${var.env}-natgw"
    Provisoning = "terraform"
  }
}

## Associate Private route table to use NAT
resource "aws_route" "ngw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw.id
  depends_on             = [aws_nat_gateway.natgw, aws_subnet.private]
}

## Associate Public route table to use IGW
resource "aws_route" "igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_internet_gateway.igw, aws_subnet.public]
}

resource "aws_route_table_association" "public" {
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
  count          = length(var.zones)
}

resource "aws_route_table_association" "private" {
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
  count          = length(var.zones)
}

resource "aws_route_table_association" "db_private" {
  subnet_id      = element(aws_subnet.db_private.*.id, count.index)
  route_table_id = aws_route_table.db_private.id
  count          = length(var.zones)
}