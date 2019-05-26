resource "aws_vpc" "exp_kafka_vpc" {
  cidr_block = "10.201.0.0/16"
  tags = "${var.kafka_exp_tags}"
}



resource "aws_subnet" "exp_kafka-subnet" {
  cidr_block = "10.201.1.0/24"
  vpc_id = "${aws_vpc.exp_kafka_vpc.id}"
  tags = "${var.kafka_exp_tags}"
}

resource "aws_eip" "kafka_ip_address" {
  instance = "${aws_instance.kafka_instance.id}"
  vpc = true
  tags = "${var.kafka_exp_tags}"

}

resource "aws_internet_gateway" "kafka_cluster_internet_gateway" {
  vpc_id = "${aws_vpc.exp_kafka_vpc.id}"
  tags = "${var.kafka_exp_tags}"
}

resource "aws_route_table" "internet_router" {
  vpc_id = "${aws_vpc.exp_kafka_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.kafka_cluster_internet_gateway.id}"
  }

}

resource "aws_route_table_association" "internet_gateway_association" {
  route_table_id = "${aws_route_table.internet_router.id}"
  subnet_id = "${aws_subnet.exp_kafka-subnet.id}"
}
