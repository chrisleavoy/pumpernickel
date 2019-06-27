provider "aws" {
  region = "us-east-1"

  // see https://www.terraform.io/docs/providers/aws/
  // access_key = "assumed set externally"
  // secret_key = "assumed set externally"
}

terraform {
  required_version = "0.12.3"

  backend "s3" {
    # All projects should use the same `bucket` and `dynamodb_table`
    bucket         = "pumpernickel-crl"
    dynamodb_table = "pumpernickel-state-lock-dynamo"

    # IMPORTANT: `key` should match the git project structure, and must be unique for all projects
    key = "pumpernickel/traffic/terraform.tfstate"

    # IMPORTANT: region should always be us-east-1, independant of project resources
    region = "us-east-1"
  }
}
