# Define your provider configuration (AWS in this case)
provider "aws" {
  region = "ap-south-1"
}



# Create the S3 bucket for backup
resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-abcdesfr"
  # acl    = "private"
}

# resource "aws_s3_bucket_acl" "example" {
#   bucket = aws_s3_bucket.example.id
#   # acl    = "private"
# }

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create an IAM policy for backup
resource "aws_iam_policy" "backup_policy" {
  name        = "backup_policy"
  path        = "/"
  description = "Policy for S3 backup"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketVersioning",
        "s3:PutObject",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.example.id}",
        "arn:aws:s3:::${aws_s3_bucket.example.id}/*"
      ]
    }
  ]
}
POLICY
}

# Create an IAM user for backup
resource "aws_iam_user" "backup_user" {
  name = "backup_user"
}

# Attach the IAM policy to the backup user
resource "aws_iam_user_policy_attachment" "backup_user_policy" {
  user       = aws_iam_user.backup_user.name
  policy_arn = aws_iam_policy.backup_policy.arn
}

# Generate an access key for the backup user
resource "aws_iam_access_key" "backup_access_key" {
  user = aws_iam_user.backup_user.name
}

# Output the access key and secret key for the backup user
output "backup_access_key" {
  value     = aws_iam_access_key.backup_access_key.id
  sensitive = true
}

output "backup_secret_key" {
  value     = aws_iam_access_key.backup_access_key.secret
  sensitive = true
}
