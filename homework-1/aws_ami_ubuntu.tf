terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_key_pair" "id_rsa" {
  key_name   = "id_rsa"
  public_key = file("/home/michal/.ssh/id_rsa.pub")
}

resource "aws_instance" "app_server" {
  ami                    = "ami-036d46416a34a611c"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.id_rsa.key_name
  vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/michal/.ssh/id_rsa")
    timeout     = "10m"
  }
}

resource "aws_security_group" "main" {
  ingress {
    description = "SSH"
    from_port   = 22  # SSH client port is not a fixed port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #allow web traffic. 46.64.73.251/32
  }

 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}