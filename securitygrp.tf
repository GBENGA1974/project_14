# security group for VPC


# SECURITY GROUP FOR VPC

resource "aws_security_group" "project14-vpc-security-group" {
  name        = "project14-vpc-security-group"
  description = "Allow ssh and HTTP access or port 80 and 22 and outbound traffic to project14_vpc"
  vpc_id      = aws_vpc.project14_vpc.id


  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project14-vpc-security-group"
  }
}

# SECURITY GROUP FOR LOAD BALANCER

resource "aws_security_group" "lb" {
    name   = "allow-all-lb"
  vpc_id = aws_vpc.project14_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}