output "bastion_ip" {
  value = "Bastion IP is ${aws_eip.kafka_ip_address.public_ip}"
}
//output "private_brokers0" {
//  value = "Private brokers ${aws_instance.kafka_instance_private_brokers.0.private_dns}"
//}
//output "private_brokers1" {
//  value = "Private brokers ${aws_instance.kafka_instance_private_brokers.1.private_dns}"
//}


output "kafka_config_pu0" {
  value = "Config run on public 0 : ${data.template_file.kafka_config_pu0.rendered}"
}

output "kafka_config_pr0" {
  value = "Config run on private 0 : ${data.template_file.kafka_config_pr0.rendered}"
}

output "kafka_config_pr1" {
  value = "Config run on private 1 : ${data.template_file.kafka_config_pr1.rendered}"
}


output "kafka_server_config_pu0" {
  value = "Config executed on the server PU0 is ${aws_instance.kafka_instance_public_broker.user_data}"
}


output "kafka_server_config_pr0" {
  value = "Config executed on the server PR0 is ${aws_instance.kafka_instance_private_brokers_1.user_data}"
}


output "kafka_server_config_pr1" {
  value = "Config executed on the server PR1 is ${aws_instance.kafka_instance_private_brokers_2.user_data}"
}

output "private_dns" {
  value = "DNS: ${aws_instance.kafka_instance_public_broker.private_dns}"
}