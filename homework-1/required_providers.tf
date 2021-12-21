terraform {
  required_providers {
#     aws = {
#      source  = "hashicorp/aws"
#      version = "~> 3.27"
#    }
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
    required_version = ">= 0.14.9"
}
