resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-states-repo"
  acl    = "private"

  tags = {
    Name        = "Terraform state bucket"
    Environment = "Prod"
  }
}