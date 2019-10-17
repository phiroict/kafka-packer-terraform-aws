terraform  {
  source = "git@github.com:phiroict/kafka-packer-terraform-aws.git//terraform?ref=v0.4.1"
  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]

    # With the get_terragrunt_dir() function, you can use relative paths!
    arguments = [
      "-var-file=secrets.json"
    ]
  }
}

inputs = {
  environment_tg = "IAmTerragruntHearMeGrunt"
  base_kafka_image_ami = "ami-03b6907c6bb88e324"
  region = "ap-southeast-2"
}