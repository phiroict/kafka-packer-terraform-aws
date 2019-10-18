resource "aws_instance" "bastion" {
  count = var.build_bastion == true?1:0
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.small"
  key_name = "kafka-keypair"
  subnet_id = aws_subnet.exp_kafka-private-subnet[0].id
  security_groups = [aws_security_group.kafka_cluster_bastion.id]
  lifecycle {
    ignore_changes = all
  }
}