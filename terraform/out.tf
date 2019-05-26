output "bastion_ip" {
  value = "Bastion IP is ${aws_eip.kafka_ip_address.public_ip}"
}