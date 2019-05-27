terragrunt = {
  terraform = {
    source = "git@github.com:phiroict/kafka-packer-terraform-aws.git//terraform?ref=v0.0.0"
    local = {}
    required_var_files = [
      "secret.tfvar"
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