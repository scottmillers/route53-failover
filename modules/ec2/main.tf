
# Define a list of local variables
locals {
  instance_type = "t2.micro"
}

# Get the region from the provider
data "aws_region" "current" {
  provider = aws.alternative
}

// get the default vpc id
data "aws_vpc" "default" {
  provider = aws.alternative
  default = true

}
// get all subnets ids in the default vpc
data "aws_subnets" "subnets" {
  provider = aws.alternative
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



# Create a security group for my web server
resource "aws_security_group" "web_srv_sg" {
  provider =  aws.alternative
  vpc_id = data.aws_vpc.default.id
  name   = "websrvsg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows HTTP from anywhere. Modify as needed.
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows SSH from anywhere. Modify as needed.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Get the Latest Amazon Linux 2 ARM AMI
data "aws_ami" "latest_amzn2_ami" {
  provider = aws.alternative
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"] # this kernel is shown in the console quickstart
    #values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    #values = ["arm64"]
    values = ["x86_64"]
  }
}




# Create a web server
resource "aws_instance" "websrv_one" {
  provider                    = aws.alternative
  subnet_id                   = data.aws_subnets.subnets.ids[0]
  ami                         = data.aws_ami.latest_amzn2_ami.id
  instance_type               = local.instance_type
  user_data                   = file("${path.module}/scripts/ec2-user-data.sh")
  #associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_srv_sg.id]
  #key_name                    = var.ssh_public_key
}

# Create an Elastic IP address
resource "aws_eip" "websrv_eip" {
  provider = aws.alternative
  domain = "vpc"
}

# Associate the Elastic IP address with the web server instance
resource "aws_eip_association" "websrv_eip_assoc" {
  provider        = aws.alternative
  instance_id     = aws_instance.websrv_one.id
  allocation_id   = aws_eip.websrv_eip.id
}

