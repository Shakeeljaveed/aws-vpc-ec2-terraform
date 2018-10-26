resource "aws_vpc" "terraform-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "terra-vpc"
  }
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-2a"

  tags {
    Name = "Public-Subnet"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "us-east-2b"

  tags {
    Name = "Private-Subnet"
  }
}

# Define the internet subnet
resource "aws_internet_gateway" "int_gateway" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  tags {
    Name = "VPC-IGW"
  }
}

# Define the route table subnet
resource "aws_route_table" "public-route" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.int_gateway.id}"
  }

  tags {
    Name = "Public-Subnet-RouteTable"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "public-route" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public-route.id}"
}

# Define the security group
resource "aws_security_group" "sgterra" {
  name = "sg_terra_vpc"
  description = "Allow incoming HTTP connections & SSH access"

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
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.terraform-vpc.id}"

  tags {
    Name = "Web Server SG"
  }
}
