# Saving states in S3
terraform {
  backend "s3" {
    bucket  = "terraform-state-testtask"                      #change
    key     = "modules/terraform-state"
    region  = "us-east-2"
    profile = "default"                        #change
  }
}


data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket   = "terraform-state-testtask"
    key      = "modules/terraform-state"
    region   = "us-east-2"
    profile  = "default"
   }
}