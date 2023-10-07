variable "instance_ami" {
  default = "ami-0f5ee92e2d63afc18"
  
}
variable "instance_name" {
  default = "single-instance"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
  default = "t2.micro"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}


variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs."
  type        = list(string)
  default = [ "sg-0717f359f1c260622" ]
}

variable "subnet_id" {
  description = "The ID of the subnet in which to launch the instance."
  type        = string
  default = "subnet-0436b510ed3cb5396"
}

# variable "instance_tags" {
#   description = "Tags to apply to the EC2 instance."
#   type        = map(string)
#   default = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }
