terragrunt = {
  terraform = {
    source = "git@github.com:phiroict/kafka-packer-terraform-aws.git//terraform?ref=v0.0.2"
    local = {}
    extra_arguments "-var-file" {
      required_var_files = [
        "secrets.tfvars"
      ]
    }
    arguments = [
      "-var-file=secrets.tfvars",
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