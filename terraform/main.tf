resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.small"
  key_name = "kafka-keypair"
  subnet_id = aws_subnet.exp_kafka-subnet-se-2b.id
  security_groups = [aws_security_group.kafka_cluster_bastion.id]
}