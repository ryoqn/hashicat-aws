module "s3-bucket" {
  name          = "hashicat-aws"
  source        = "app.terraform.io/ryoqn-training/s3-bucket/aws"
  version       = "2.2.0"
  bucket_prefix = var.prefix
}