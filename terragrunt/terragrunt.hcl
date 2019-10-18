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
  base_kafka_image_ami = "ami-0e33f298f56c8ed6c"
  region = "ap-southeast-2"
  build_bastion = true
  kafka_cluster_name = "PhiRo's impressive cluster"
  kafka_cluster_size = 3
}