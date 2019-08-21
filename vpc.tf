# Internet VPC
resource "aws_vpc" "VPC" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
#    tags {
#        Name = "${var.ENV}-VPC"
#    }
}

# Subnets
resource "aws_subnet" "Public-AZ1-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PublicSubnetAZ1CIDR}"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1a"

#    tags {
#        Name = "${var.ENV}-VPC-Public-AZ1-SN"
#    }
}
resource "aws_subnet" "Public-AZ2-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PublicSubnetAZ2CIDR}"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1b"

#    tags {
#        Name = "${var.ENV}-VPC-Public-AZ2-SN"
#    }
}

resource "aws_subnet" "Private-AZ1-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PrivateSubnetAZ1CIDR}"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1a"

#    tags {
#        Name = "${var.ENV}-VPC-Private-AZ1-SN"
#    }
}
resource "aws_subnet" "Private-AZ2-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PrivateSubnetAZ2CIDR}"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1b"

#    tags {
#        Name = "${var.ENV}-VPC-Private-AZ2-SN"
#    }
}

# Internet GW
resource "aws_internet_gateway" "Igw" {
    vpc_id = "${aws_vpc.VPC.id}"

#    tags {
#        Name = "${var.ENV}-VPC-IGW"
#    }
}

# route tables
resource "aws_route_table" "Public-RT" {
    vpc_id = "${aws_vpc.VPC.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.Igw.id}"
    }

#    tags {
#        Name = "${var.ENV}-VPC-Public-RT"
#    }
}

# route associations public
resource "aws_route_table_association" "Public-AZ1-RT" {
    subnet_id = "${aws_subnet.Public-AZ1-SN.id}"
    route_table_id = "${aws_route_table.Public-RT.id}"
}
resource "aws_route_table_association" "Public-AZ2-RT" {
    subnet_id = "${aws_subnet.Public-AZ2-SN.id}"
    route_table_id = "${aws_route_table.Public-RT.id}"
}

# route associations private
resource "aws_route_table" "Private-RT" {
    vpc_id = "${aws_vpc.VPC.id}"
#    tags {
#        Name = "${var.ENV}-VPC-Private-RT"
#    }
}
#route associations private
resource "aws_route_table_association" "Private-AZ1-RT" {
    subnet_id = "${aws_subnet.Private-AZ1-SN.id}"
    route_table_id = "${aws_route_table.Private-RT.id}"
}
resource "aws_route_table_association" "Private-AZ2-RT" {
    subnet_id = "${aws_subnet.Private-AZ2-SN.id}"
    route_table_id = "${aws_route_table.Private-RT.id}"
}