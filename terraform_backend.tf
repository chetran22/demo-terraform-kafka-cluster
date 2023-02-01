terraform {
  backend "s3" {
    # bucket is in ada-nonprod.*/*/*/backend.tfvars
    bucket = "terraform.kafka.kf.dev1.adarasoft"
    key            = "terraform.tfstate"
    region         = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform_lock_table"
    encrypt        = true
  }
}
