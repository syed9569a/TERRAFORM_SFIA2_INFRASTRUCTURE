provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

module "sfia2_vpc" {
  source = "./VPC"
}

module "sg_master_myip" {
  sg_web_name = "Master SG For My IP"
  source = "./SG"
  ip_addresses = "109.145.74.222/32"
  ingress_ports = [22, 8080]
  vpc_id = module.sfia2_vpc.vpc_id
}

module "sg_master_open" {
  sg_web_name = "Master SG Open"
  source = "./SG"
  ingress_ports = [80]
  vpc_id = module.sfia2_vpc.vpc_id
}

module "sg_worker_myip" {
  sg_web_name = "Worker SG For My IP"
  source = "./SG"
  ip_addresses = "109.145.74.222/32"
  vpc_id = module.sfia2_vpc.vpc_id
}

data "template_file" "init" {
  template = "${file("${path.module}/scripts/setup.sh")}"
}

module "master_node" {
  source = "./EC2"
  name = "Master"
  subnet_id = module.sfia2_vpc.subnet_a_id
  vpc_security_group_ids = [module.sg_master_myip.sg_id, module.sg_master_open.sg_id]
  user_data = data.template_file.init.rendered
}

module "worker_node" {
  source = "./EC2"
  name = "Worker"
  subnet_id = module.sfia2_vpc.subnet_a_id
  vpc_security_group_ids = [module.sg_worker_myip.sg_id]
}
