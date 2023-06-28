provider "aws" {}

data "terraform_remote_state" "random_name" {
  backend = "local"

  config = {
    path = "../learn-terraform-random/terraform.tfstate"
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = data.terraform_remote_state.random_name.outputs.random_name_str
  #bucket = var.bucket_name
  #bucket                   = "s3-bucket-tf"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
