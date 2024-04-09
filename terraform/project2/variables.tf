variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  
}

variable "key_name" {
  description = "The name of the Terraform state file"
}

variable "region" {
  description = "The AWS region where the S3 bucket is located"
}