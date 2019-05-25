resource "aws_vpc" "exp_kafka_vpc" {
  cidr_block = "10.201.0.0/16"
}

resource "aws_subnet" "exp_kafka-subnet" {
  cidr_block = "10.201.1.0/24"
  vpc_id = "${aws_vpc.exp_kafka_vpc.id}"
}

resource "aws_eip" "kafka_ip_address" {
  instance = "${aws_instance.kafka_instance.id}"
  vpc = true
}