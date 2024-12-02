# Declare the availability zone data source
data "aws_availability_zones" "available" {
  state = "available"
}
### Create the VPC
# resource "aws_vpc" "main" {
#   name = "wenorg-dev-app_vpc"
#   # cidr_block       = var.vpc_cidr
#   # instance_tenancy = "default"
#   # tags = {
#   #   Name = "${var.business_division}-${var.environment}-app_vpc"
#   # }
#   # vpc_id = var.vpc_id
#   id = var.vpc_id
# }
data "aws_vpc" "main" {
  # name = "wenorg-dev-app_vpc"
  # cidr_block       = var.vpc_cidr
  # instance_tenancy = "default"
  # tags = {
  #   Name = "${var.business_division}-${var.environment}-app_vpc"
  # }
  # vpc_id = var.vpc_id
  id = var.vpc_id
}

output "aws_vpc" {
  value = data.aws_vpc.main.id
}

### Create the public subnet - 2 
# resource "aws_subnet" "public" {
#   count                   = var.subnet_count[var.environment]
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.business_division}-${var.environment}-public_subnet-${count.index}"
#   }
# }
# output "aws_subnet" {
#   value = aws_subnet.public[*].id
# }
# ### Create internet gateway
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "${var.business_division}-${var.environment}-main_igw"
#   }
# }

# output "aws_internet_gateway" {
#   value = aws_internet_gateway.igw.id
# }

# ### Public route table
# resource "aws_route_table" "rtb-public" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "${var.business_division}-${var.environment}-Public-RT"
#   }
# }
# # We use the count meta argument to dynamically retrieve the id’s of our public subnet that were dynamically generated.
# resource "aws_route" "rtb-public-route" {
#   route_table_id         = aws_route_table.rtb-public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }
# resource "aws_route_table_association" "pub-rtb-asoc" {
#   count          = var.subnet_count[var.environment]
#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.rtb-public.id
# }
### Create the private subnet
# resource "aws_subnet" "private" {
#   # count      = var.subnet_count[var.environment]
#   # vpc_id = aws_vpc.main.id
#   vpc_id = var.vpc_id
#   # cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
#   cidr_block       = var.vpc_cidr
#   # tags = {
#   #   Name = "${var.business_division}-${var.environment}-private_subnet-${count.index}"
#   # }
# }
data "aws_subnet" "private" {
  # count      = var.subnet_count[var.environment]
  # vpc_id = aws_vpc.main.id
  # id = var.vpc_id
  # id = var.subnets
  # cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  # cidr_block       = var.vpc_cidr
  # tags = {
  #   Name = "${var.business_division}-${var.environment}-private_subnet-${count.index}"
  # }
  # Optional attributes to filter the search
  filter {
    # name   = "tag:Name"
    # values = ["Public Subnet"]
    # name = "wenorg-dev-private_subnet-0"
    # name = "wenorg-dev-private_subnet-[*]"
    # name   = "Name:wenorg-dev-public_subnet-0"
    # name = "tag:Name"
    # name   = "tag:service"
    # values = ["ecs"]
    # name = "Name"
    # name   = "Name:wenorg-dev-public_subnet-0"
    # values = ["subnet-0ea81a1bd380591b1", "subnet-06fb14cf3a77c06d8"]
    # values = ["private Subnet 1", "Private Subnet 2"]
    name   = "tag:Name"
    values = ["wenorg-dev-private_subnet-0", "Name:wenorg-dev-public_subnet-1"]
  }

  # filter {
  #   name = "vpc-id"
  #   values = [
  #     data.aws_vpc.main.id
  #   ]
  # }

  # filter {
  #   name = "map-public-ip-on-launch"
  #   values = [false]
  # }
}


resource "aws_eip" "eip" {
  domain = "vpc"
}
# resource "aws_nat_gateway" "ngw" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public[0].id
#   # NAT gateway is created in the public subnet but used by the private subnet
#   tags = {
#     Name = "${var.business_division}-${var.environment}-gw NAT"
#   }
# }
# To ensure proper ordering, it is recommended to add an explicit dependency
### Private route table
resource "aws_route_table" "rtb-private" {
  # vpc_id = aws_vpc.main.id
  vpc_id = var.vpc_id
  # tags = {
  #   Name = "${var.business_division}-${var.environment}-Public-RT"
  # }
}
resource "aws_route" "rtb-private-route" {
  route_table_id         = aws_route_table.rtb-private.id
  destination_cidr_block = "0.0.0.0/0"
  # gateway_id             = aws_nat_gateway.ngw.id
  # gateway_id = "igw-0720b0e0754243cc3"
  gateway_id = var.igw_id
}
# resource "aws_route_table_association" "priv-rtb-asoc" {
#   count          = var.subnet_count[var.environment]
#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.rtb-private.id
# }