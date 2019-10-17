
resource "aws_instance" "kafka_instance_private_brokers" {
  count = var.kafka_cluster_size
  ami = var.base_kafka_image_ami
  instance_type = var.kafka_instance_type
  key_name = "kafka-keypair"
  vpc_security_group_ids = [
    aws_security_group.kafka_cluster.id,
  ]
  subnet_id = aws_subnet.exp_kafka-subnet-se-2b.id
  private_ip = format (var.core_ip_subnet , tostring(var.core_ip_subnet_start+count.index))
  tags = merge(
  var.kafka_exp_tags,
  {
    "Name" = format(
    "PhiRo_Kafka_Private Instances_Experimental_%d number 1",
    count.index,
    )
  }, {
    "CreatedAt" = timestamp(),
  }, {
    "ExpiresAt" = timeadd(timestamp(), "26280h")
  }
  )
  depends_on = [
    aws_internet_gateway.kafka_cluster_internet_gateway,
    aws_key_pair.kafka-keypair,
  ]
  user_data = data.template_file.kafka_config_pr0.rendered
}


