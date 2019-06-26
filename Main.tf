provider "aws" {
  region     = "${var.aws_region}"
  access_key = "AKIA2XBEWL5ZYC6BACXM"
  secret_key = "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"
}


## vpc creation

resource "aws_vpc" "Dev-vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Dev"
  }
}
## Public Subnet

resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.Dev-vpc.id}"
  cidr_block = "${var.pub_sub}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Public_subnet"
  }
}

resource "aws_route_table" "public-routetable" {
    vpc_id = "${aws_vpc.Dev-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.IGW.id}"
    }

    tags {
        Name = "Public_Routetable"
    }
}

resource "aws_route_table_association" "public-routetable1" {
    subnet_id = "${aws_subnet.public-subnet.id}"
    route_table_id = "${aws_route_table.public-routetable.id}"
}


## Private Subnet

resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.Dev-vpc.id}"
  cidr_block = "${var.prv_sub}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Private_subnet"
  }
}

## IGW

# Define the internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = "${aws_vpc.Dev-vpc.id}"

  tags {
    Name = "DEV_IGW"
  }
}



