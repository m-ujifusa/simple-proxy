terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    bucket = "your-s3-bucket"
    key    = "simple-proxy.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
  }
}