resource "aws_key_pair" "kafka-keypair" {
  public_key = "${var.public_key_kafka-keypair}"
  key_name = "kafka-keypair"

}

resource "aws_instance" "kafka_instance" {
  ami = "${var.base_kafka_image_aim}"
  instance_type = "${var.instance_type}"
  key_name = "kafka-keypair"
  vpc_security_group_ids = ["${aws_security_group.kafka_cluster.id}"]
  subnet_id = "${aws_subnet.exp_kafka-subnet.id}"
  tags = "${var.kafka_exp_tags}"
  depends_on = ["aws_internet_gateway.kafka_cluster_internet_gateway"]
}

