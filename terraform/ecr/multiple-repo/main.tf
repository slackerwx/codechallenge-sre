provider "aws" {
  region = "us-east-1"
}

module "ecr" {
  source = "../"
  image_names = ["auth","booking","client","graphql"]
}
