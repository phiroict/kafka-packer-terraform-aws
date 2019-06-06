resource "aws_instance" "kafka_instance_public_broker" {
  ami = "${var.base_kafka_image_ami}"
  instance_type = "${var.instance_type}"
  key_name = "kafka-keypair"
  vpc_security_group_ids = [
    "${aws_security_group.kafka_cluster.id}"]
  subnet_id = "${aws_subnet.exp_kafka-subnet-se-2a.id}"
  private_ip = "10.201.1.100"
  tags = "${merge(var.kafka_exp_tags,  map("Name",format("PhiRo_Kafka_Public Instance_Experimental_%s", var.environment_tg )))}"
  depends_on = [
    "aws_internet_gateway.kafka_cluster_internet_gateway",
    "aws_key_pair.kafka-keypair"]
  user_data = "${data.template_file.kafka_config_pu0.rendered}"

}

resource "aws_instance" "kafka_instance_private_brokers_1" {

  ami = "${var.base_kafka_image_ami}"
  instance_type = "${var.instance_type}"
  key_name = "kafka-keypair"
  vpc_security_group_ids = [
    "${aws_security_group.kafka_cluster.id}"]
  subnet_id = "${aws_subnet.exp_kafka-subnet-se-2b.id}"
  private_ip = "10.201.2.100"
  tags = "${merge(var.kafka_exp_tags,  map("Name",format("PhiRo_Kafka_Private Instances_Experimental_%s number 1", var.environment_tg )))}"
  depends_on = [
    "aws_internet_gateway.kafka_cluster_internet_gateway",
    "aws_key_pair.kafka-keypair"]
  user_data = "${data.template_file.kafka_config_pr0.rendered}"

}

resource "aws_instance" "kafka_instance_private_brokers_2" {

  ami = "${var.base_kafka_image_ami}"
  instance_type = "${var.instance_type}"
  key_name = "kafka-keypair"
  vpc_security_group_ids = [
    "${aws_security_group.kafka_cluster.id}"]
  subnet_id = "${aws_subnet.exp_kafka-subnet-se-2c.id}"
  private_ip = "10.201.3.100"
  tags = "${merge(var.kafka_exp_tags,  map("Name",format("PhiRo_Kafka_Private Instances_Experimental_%s number 2", var.environment_tg )))}"
  depends_on = [
    "aws_internet_gateway.kafka_cluster_internet_gateway",
    "aws_key_pair.kafka-keypair"]
  user_data = "${data.template_file.kafka_config_pr1.rendered}"

}