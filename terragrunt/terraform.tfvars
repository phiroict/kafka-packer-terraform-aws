terragrunt = {
  terraform = {
    source = "git@github.com:phiroict/kafka-packer-terraform-aws.git//terraform?ref=v0.0.2"
    local = {}

    arguments = [
      "-var-file=${get_tfvars_dir()}/secrets.tfvars"
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
base_kafka_image_ami="ami-0555bc9bd3a39b785"