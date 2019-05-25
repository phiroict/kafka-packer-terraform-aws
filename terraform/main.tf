resource "aws_key_pair" "kafka-keypair" {
  public_key = "${var.public_key_kafka-keypair}"
  key_name = "kafka-keypair"
}

resource "aws_instance" "kafka_instance" {
  ami = "${var.base_kafka_image_aim}"
  instance_type = "${var.instance_type}"
  key_name = "kafka-keypair"
  tags {
    Author= "Philip Rodrigues"
    State= "Experimental"
    ExpiresAt = "20190625"
    Department = "CloudOps"
    Name = "Experimental_kafka_cluster_instance"
  }
}

