#variable
#provider
provider "aws" {
  access_key = "AKIA46ZNEKWHFFX2TLN4"
    secret_key = "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"
    region = "us-east-1"
}
#resources
resource "aws_security_group" "SG" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}
    
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-09c813fb71547fc4f" # Amazon Linux 2 AMI
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.SG.id]
  user_data = file("scripts.sh")

  tags = {
    Name = "myinstance"
  }
}
#outputs
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.my_ec2_instance.public_ip
}