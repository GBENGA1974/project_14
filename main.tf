# create vpc and subnet

resource "aws_vpc" "project14_vpc" {
  cidr_block       = var.cidr_block[0]
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true


  tags = {
    Name = "project14_vpc"
  }
}

# PUBLIC SUBNET1

resource "aws_subnet" "project14-pubsubnet1" {
  vpc_id     = aws_vpc.project14_vpc.id
  cidr_block = var.cidr_block[1]
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"


  tags = {
    Name = "project14-pubsubnet1"
  }
}

# PUBLIC SUBNET2

resource "aws_subnet" "project14-pubsubnet2" {
  vpc_id     = aws_vpc.project14_vpc.id
  cidr_block = var.cidr_block[2]
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"


  tags = {
    Name = "project14-pubsubnet2"
  }
}

# PUBLIC SUBNET3

resource "aws_subnet" "project14-pubsubnet3" {
  vpc_id     = aws_vpc.project14_vpc.id
  cidr_block = var.cidr_block[3]
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"


  tags = {
    Name = "project14-pubsubnet3"
  }
}

# PRIVATE SUBNET1

resource "aws_subnet" "project14-private_subnet1" {
  vpc_id     = aws_vpc.project14_vpc.id
  cidr_block = var.cidr_block[4]
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"


  tags = {
    Name = "project14_private_subnet1"
  }
}

# PRIVATE SUBNET2

resource "aws_subnet" "project14-private_subnet2" {
  vpc_id     = aws_vpc.project14_vpc.id
  cidr_block = var.cidr_block[5]
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"


  tags = {
    Name = "project14_private_subnet2"
  }
}

# PRIVATE SUBNET3
resource "aws_subnet" "project14-private_subnet3" {
  vpc_id     = aws_vpc.project14_vpc.id
  cidr_block = var.cidr_block[6]
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1b"


  tags = {
    Name = "project14_private_subnet3"
  }
}

# PUBLIC ROUTE TABLE

resource "aws_route_table" "project14_public_route_table" {
  vpc_id = aws_vpc.project14_vpc.id

  tags = {
    Name = "project14_route_table"
  }
}

# PRIVATE ROUTE TABLE

resource "aws_route_table" "project14_private_route_table" {
  vpc_id = aws_vpc.project14_vpc.id

  tags = {
    Name = "project14_route_table"
  }
}

# INTERNET GATEWAY

resource "aws_internet_gateway" "project14-igw" {
  vpc_id = aws_vpc.project14_vpc.id

  tags = {
    Name = "PROJECT14-igw"
  }
}

# IGW ASSOCIATION WITH ROUTE TABLE

resource "aws_route" "Association_public-RT" {
  route_table_id            = aws_route_table.project14_public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.project14-igw.id
}

# ASSOCIATE PUBLIC SUBNET1 TO PUBLIC ROUTE

resource "aws_route_table_association" "project14-PUBSUB1-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.project14-pubsubnet1.id
  route_table_id = aws_route_table.project14_public_route_table.id
}

resource "aws_route_table_association" "project14-PUBSUB2-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.project14-pubsubnet2.id
  route_table_id = aws_route_table.project14_public_route_table.id
}

resource "aws_route_table_association" "project14-PUBSUB3-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.project14-pubsubnet3.id
  route_table_id = aws_route_table.project14_public_route_table.id
}

resource "aws_route_table_association" "project14-PRIVSUB1-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.project14-private_subnet1.id
  route_table_id = aws_route_table.project14_private_route_table.id
}

resource "aws_route_table_association" "project14-PRIVSUB2-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.project14-private_subnet2.id
  route_table_id = aws_route_table.project14_private_route_table.id
}

resource "aws_route_table_association" "project14-PRIVSUB3-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.project14-private_subnet3.id
  route_table_id = aws_route_table.project14_private_route_table.id
}