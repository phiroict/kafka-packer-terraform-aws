resource "aws_security_group" "kafka_cluster" {
  name        = "cluster_configuration"
  description = "Allow cluster configuration and communication"
  vpc_id      = "${aws_vpc.exp_kafka_vpc.id}"

  ingress {
    cidr_blocks = ["111.69.227.166/32"]
    protocol = "icmp"
    from_port = 8
    to_port = 0
  }

  ingress {
    # SSH for initial processing
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["111.69.227.166/32"]
  }

  ingress {
    # Kafka access
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["111.69.227.166/32", "${aws_subnet.exp_kafka-subnet.cidr_block}"]
  }

  ingress {
    # Zookeer access
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["111.69.227.166/32", "${aws_subnet.exp_kafka-subnet.cidr_block}"]
  }

  ingress {
    # Kafka cluster communication
    from_port   = 2888
    to_port     = 2888
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["${aws_subnet.exp_kafka-subnet.cidr_block}"]
  }

  ingress {
    # Kafka cluster leader communication
    from_port   = 3888
    to_port     = 3888
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["${aws_subnet.exp_kafka-subnet.cidr_block}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = "${var.kafka_exp_tags}"
}