output "bastion_ip" {
  value = "Bastion IP is ${aws_eip.kafka_ip_address.public_ip}"
}

//output "private_brokers0" {
//  value = "Private brokers ${aws_instance.kafka_instance_private_brokers.0.private_dns}"
//}
//output "private_brokers1" {
//  value = "Private brokers ${aws_instance.kafka_instance_private_brokers.1.private_dns}"
//}

output "kafka_config_pr0" {
  value = "Config run on private 0 : ${data.template_file.kafka_config_pr0.rendered}"
}

output "kafka_server_config_pr0" {
  value = {
    for a in aws_instance.kafka_instance_private_brokers:
    a.user_data => a.user_data...
}
}



