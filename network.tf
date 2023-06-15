########## Define the VPC ###############

resource "aws_vpc" "initial_vpc" {
  cidr_block = "192.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Initial VPC"
  }
}

######### Define the subnets #############

data "aws_availability_zones" "available" {}
resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "random_shuffle" "public_az" {
  input        = data.aws_availability_zones.available.names
  result_count = 10
}
resource "aws_subnet" "web_subnet_1" {
  vpc_id = aws_vpc.initial_vpc.id
  availability_zone     = "ap-south-1"
  cidr_block = "192.0.7.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Web Server Subnet - 1"
  }
}

resource "aws_subnet" "web_subnet_2" {
  vpc_id = aws_vpc.initial_vpc.id
  availability_zone     = "ap-south-2"
  cidr_block = "192.0.6.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Web Server Subnet - 2"
  }
}



resource "aws_subnet" "db_subnet_1" {
  vpc_id = aws_vpc.initial_vpc.id
  cidr_block = "192.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-south-1"

  tags = {
    Name = "DB Subnet 1"
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id                  = aws_vpc.initial_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-south-2"

  tags = {
    Name = "DB Subnet 2"
  }
}
########### Define subnet group for DB ############
resource "aws_db_subnet_group" "subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.db_subnet_1.id, aws_subnet.db_subnet_2.id]
}

########## Define internet gateway ##################

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.initial_vpc.id

  tags = {
    Name = "Internet GW"
  }
}
