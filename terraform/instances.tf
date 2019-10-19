
resource "aws_instance" "kafka_instance_private_brokers" {
  count = var.kafka_cluster_size
  ami = var.base_kafka_image_ami
  instance_type = var.kafka_instance_type
  key_name = "kafka-keypair"
  vpc_security_group_ids = [
    aws_security_group.kafka_cluster.id,
  ]
  subnet_id = aws_subnet.exp_kafka-private-subnet[count.index % length(var.azs)].id

  tags = merge(
  var.kafka_exp_tags,
  {
    "Name" = format(
    "${var.kafka_cluster_name}${"_%d"}",
    count.index,
    )
  }, {
    "CreatedAt" = timestamp(),
  }, {
    "ExpiresAt" = timeadd(timestamp(), "26280h")
  }, {
    "AnsibleType": "Zookeeper"
  }
  )
  depends_on = [
    aws_internet_gateway.kafka_cluster_internet_gateway,
    aws_key_pair.kafka-keypair,
  ]
}


