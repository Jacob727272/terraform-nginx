variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
  default = "ami-091138d0f0d41ff90"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "jacob"
}

variable "server_name" {
  type    = string
  default = "nginx-server"
}
