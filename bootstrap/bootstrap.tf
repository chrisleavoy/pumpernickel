provider "aws" {
  region = "us-east-1"

  // see https://www.terraform.io/docs/providers/aws/
  // access_key = "assumed set externally"
  // secret_key = "assumed set externally"
}

// An S3 Bucket for various use, but primarily storing remote terraform state
// See http://code.hootsuite.com/how-to-use-terraform-and-remote-state-with-s3/
resource "aws_s3_bucket" "pumpernickel-crl" {
  bucket = "pumpernickel-crl"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }
}

// remote state https://medium.com/@jessgreb01/how-to-terraform-locking-state-in-s3-2dc9a5665cb6
resource "aws_dynamodb_table" "pumpernickel-terraform-state-lock" {
  name           = "pumpernickel-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  required_version = "0.12.3"
}
