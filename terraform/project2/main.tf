provider "aws" {
  region = "us-east-1"

}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  azs  = ["us-east-1a"]
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  public_subnets = ["10.0.101.0/24"]


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



# Security Group
resource "aws_security_group" "my_sg" {
  name        = "instance-sg"
  description = "Security group for EC2 instance"
  vpc_id      = module.vpc.vpc_id

  # Ingress rule for SSH access
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


}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}