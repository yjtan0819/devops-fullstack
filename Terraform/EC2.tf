provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "devops-server" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    key_name = "devops-fullstack"
    //security_groups = ["${aws_security_group.devops-sg.name}"]
    vpc_security_group_ids = ["${aws_security_group.devops-sg.id}"]
    subnet_id = "${aws_subnet.devops-public-subnet-01.id}"
    for_each = toset(["jenkins-master", "build-slave", "ansible"])
    tags = {
        Name = "${each.key}"
    }
}

resource "aws_security_group" "devops-sg" {
    name        = "devops-sg"
    description = "Allow SSH access"
    vpc_id      = "${aws_vpc.devops-vpc.id}"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "ssh_prot"
  }
}

resource "aws_vpc" "devops-vpc" {
    cidr_block = "10.1.0.0/16"
    tags = {
        Name = "devops-vpc"
    }
  
}

resource "aws_subnet" "devops-public-subnet-01" {
    vpc_id = "${aws_vpc.devops-vpc.id}"
    cidr_block = "10.1.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "devops-public-subnet-01"
    }
}

resource "aws_subnet" "devops-public-subnet-02" {
    vpc_id = "${aws_vpc.devops-vpc.id}"
    cidr_block = "10.1.0.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "devops-public-subnet-02"
    }
}

resource "aws_internet_gateway" "devops-igw" {
    vpc_id = "${aws_vpc.devops-vpc.id}"
    tags = {
        Name = "devops-igw"
    }
}

resource "aws_route_table" "devops-public-rt" {
    vpc_id = "${aws_vpc.devops-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.devops-igw.id}"
    }
  
}

resource "aws_route_table_association" "devops-rta-public-subnet-01" {
    subnet_id = "${aws_subnet.devops-public-subnet-01.id}"
    route_table_id = "${aws_route_table.devops-public-rt.id}"
}

resource "aws_route_table_association" "devops-rta-public-subnet-02" {
    subnet_id = "${aws_subnet.devops-public-subnet-02.id}"
    route_table_id = "${aws_route_table.devops-public-rt.id}"
}