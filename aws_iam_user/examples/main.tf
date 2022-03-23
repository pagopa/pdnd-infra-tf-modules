provider "aws" {
  region = "eu-west-1"
}

module "iam_user2" {
  source = "../"

  name = "example"

  create_iam_user_login_profile = false
  create_iam_access_key         = true
}