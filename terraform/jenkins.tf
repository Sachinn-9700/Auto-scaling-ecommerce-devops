resource "aws_security_group" "jenkins_sg" {
    vpc_id      = aws_vpc.main.id
    name        = "jenkins-sg"
    description = "Security group for Jenkins"

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.jenkins_instance_type
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_name
  security_groups = [aws_security_group.jenkins_sg.name]

    iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
    user_data = file("user_data.sh")    
    
  tags = {
    Name = "Jenkins-Server"
  }
  
}