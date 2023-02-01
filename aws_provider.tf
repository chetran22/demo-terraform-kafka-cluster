provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment   = var.environment
      ProductCode   = var.product_code
      iacRepo       = var.iac_repo
    }
  }
}
