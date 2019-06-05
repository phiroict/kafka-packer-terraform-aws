output "bastion_ip" {
  value = "Bastion IP is ${aws_eip.kafka_ip_address.public_ip}"
}
//output "private_brokers0" {
//  value = "Private brokers ${aws_instance.kafka_instance_private_brokers.0.private_dns}"
//}
//output "private_brokers1" {
//  value = "Private brokers ${aws_instance.kafka_instance_private_brokers.1.private_dns}"
//}


output "private_dns" {
  value = "DNS: ${aws_instance.kafka_instance_public_broker.private_dns}"
}