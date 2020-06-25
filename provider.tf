provider "aws" {
  region = var.region
}

# terraform {
#   # It is expected that the bucket already exists
#   backend "s3" {
#     # a globally unique bucket name
#     bucket  = [BUCKET_NAME]
#     key     = "terraform.tfstate"
#     region  = [REGION]
#     encrypt = true
#   }
# }