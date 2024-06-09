terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

//key pair file
resource "aws_key_pair" "minecraft_keys" {
  key_name   = "minecraft_keys"
  public_key = file("./minecraft_keys_2.pub")
}

// security group
resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-069940992e9e8e05d"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
  }
}

resource "aws_instance" "minecraft_server" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.minecraft_keys.key_name
  security_groups = [aws_security_group.minecraft_sg.name]
  associate_public_ip_address = true


  tags = {
    Name = "minecraft_server"
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.minecraft_server.public_ip
}

