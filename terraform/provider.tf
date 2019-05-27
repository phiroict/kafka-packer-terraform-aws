provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "/home/vagrant/.aws/creds"
  profile                 = "sandpit"
}
