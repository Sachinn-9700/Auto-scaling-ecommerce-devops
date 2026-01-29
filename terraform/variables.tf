variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "cluster_name" {
  description = "auto-scaling-ecommerce-eks"
  type = string
}

variable "node_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "jenkins_instance_type" {
  description = "t3.micro"
}
variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}
variable "key_name" {
  description = "devops_key"
  type        = string
}
variable "ami_id" {
  description = "ami-0b6c6ebed2801a5cb"
  type = string
}