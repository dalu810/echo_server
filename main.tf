provider "aws" {
  region = "eu-west-1"  # AWS region
}

resource "aws_security_group" "echo_server_sg" {
  name        = "echo_server_test"

  ingress {
    description = "Allow SSH on port 22 from my local IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["82.203.167.39/32"]  # My local IP
  }

  ingress {
    description = "Allow http on port 8080 from my local IP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["82.203.167.39/32"]  # My local IP
  }

  ingress {
    description = "Allow HTTP on port 80 from my local IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["82.203.167.39/32"]  # My local IP
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "echo_server_sg"
  }
}


resource "aws_instance" "echo_server" {
  ami           = "ami-0fa8fe6f147dc938b"  # AMI ID
  instance_type = "t2.micro"
  key_name = "202302_ec2"
  
  security_groups = [aws_security_group.echo_server_sg.name]

  tags = {
    Name = "EchoServerInstance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -a -G docker ec2-user",
      "sudo docker run -d -p 80:8080 dalu958/echo-server:latest"  # Pull Docker image from Docker Hub and run
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("D:/workspace/keys/202302_ec2.pem")
    }
  }
  
  
}

output "ec2_public_ip" {
  value = aws_instance.echo_server.public_ip
}