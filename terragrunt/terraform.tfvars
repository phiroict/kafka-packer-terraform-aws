terragrunt = {
  terraform = {
    source = "git@github.com:phiroict/kafka-packer-terraform-aws.git//terraform?ref=v0.1.0"
    local = {}

    arguments = [
      "-var-file=secrets.tfvars"
     ]
      extra_arguments "custom_vars" {
      commands = [
        "apply",
        "plan",
        "import",
        "push",
        "refresh",
        "destroy"
      ]
    }
  }
}

environment_tg="IAmTerragruntHearMeGrunt"
base_kafka_image_ami="ami-0f6f525461ca6509b"