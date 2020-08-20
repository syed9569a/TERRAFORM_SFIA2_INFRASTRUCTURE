variable "instance" {
  description = "This variable state the instance type for your EC2"
  default     = "t2.micro"
}

variable "ami_id" {
  default = "ami-07ee42ba0209b6d77"
}

variable "key_name" {
  default = "mac-syed-key"
}

variable "subnet_id" {
  description = "Subnet ID for EC2"
}

variable "name" {
  description = "Name of EC2 Instance"
  default = "EC2200820"
}

variable "enable_public_ip" {
  description = "Enable if EC2 instace should have public ip address"
  default = true
}

variable "vpc_security_group_ids" {
  description = "VPC Security Group IDs"
}

variable "user_data" {
  description = "script to run when creating instance"
  default = "data.template_file.init.rendered"
}