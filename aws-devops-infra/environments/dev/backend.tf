terraform {
  backend "s3" {
    bucket         = "tfstate-ei"
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}