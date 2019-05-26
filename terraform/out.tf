output "bastion_ip" {
  value = "Bastion IP is ${aws_eip.kafka_ip_address.public_ip}"
}

output "private_dns" {
  value = "DNS: ${aws_instance.kafka_instance.private_dns}"
}