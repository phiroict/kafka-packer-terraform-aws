resource "aws_vpc_dhcp_options" "dhcp_kafka_dns" {
  domain_name = "kafka.cluster.internal"
  tags = "${merge(var.kafka_exp_tags,  map("Name","PhiRo_Kafka_DNS_Options_Experimental"))}"
}

resource "aws_vpc_dhcp_options_association" "vpc_dns_association" {
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp_kafka_dns.id}"
  vpc_id = "${aws_vpc.exp_kafka_vpc.id}"
}

resource "aws_instance" "kafka_instance" {
  ami = "${var.base_kafka_image_aim}"
  instance_type = "${var.instance_type}"
  key_name = "kafka-keypair"
  vpc_security_group_ids = ["${aws_security_group.kafka_cluster.id}"]
  subnet_id = "${aws_subnet.exp_kafka-subnet.id}"

  tags = "${merge(var.kafka_exp_tags,  map("Name",format("PhiRo_Kafka_Instance_Experimental_%s", var.environment_tg )))}"
  depends_on = ["aws_internet_gateway.kafka_cluster_internet_gateway"]
}

