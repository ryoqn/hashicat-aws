terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ryoqn-training"
    workspaces {
      name = "hashicat-aws"
    }
  }
}
