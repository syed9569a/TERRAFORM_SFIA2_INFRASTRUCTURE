resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance
  key_name                    = var.key_name
  associate_public_ip_address = var.enable_public_ip
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = {
    Name = var.name
  }

}