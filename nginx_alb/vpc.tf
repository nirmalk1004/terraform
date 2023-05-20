resource "aws_vpc" "alb_vpc" {
  cidr_block           = var.alb_vpc
  instance_tenancy     = var.alb_instance
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  count             = var.alb_vpc == "10.0.0.0/16" ? 2 : 0
  vpc_id            = aws_vpc.alb_vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  cidr_block        = element(cidrsubnets(var.alb_vpc, 8, 4), count.index)

  tags = {
    "Name" = "Public-Subnet-${count.index}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.alb_vpc.id

  tags = {
    "Name" = "Internet_access"
  }
}
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.alb_vpc.id

  tags = {
    "Name" = "pubRouteTable"
  }
}
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet) == 2 ? 2 : 0
  route_table_id = aws_route_table.pub_rt.id
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
}
