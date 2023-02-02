
provider "aws" {
  region     = var.aws-config.region
  access_key = var.aws-config.access_key
  secret_key = var.aws-config.secret_key
}