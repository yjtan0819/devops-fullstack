provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "devops-server" {
    ami = "ami-08a0d1e16fc3f61ea"
    instance_type = "t2.micro"
    key_name = "devops-fullstack"
    security_groups = ["${aws_security_group.devops-sg.name}"]
}

resource "aws_security_group" "devops-sg" {
  name        = "devops-sg"
  description = "Allow SSH access"

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

