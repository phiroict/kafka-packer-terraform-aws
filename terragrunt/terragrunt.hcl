terraform  {
  source = "git@github.com:phiroict/kafka-packer-terraform-aws.git//terraform?ref=v0.4.0"
}

inputs = {
  environment_tg = "IAmTerragruntHearMeGrunt"
  base_kafka_image_ami = "ami-0f6f525461ca6509b"
}