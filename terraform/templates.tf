data "template_file" "kafka_config_pr0" {
  template = file("${path.module}/kafka_zookeeper.tpl")
  vars = {
    id                  = "2"
    zk_mem              = "512"
    zookeepers_sequence = "1:10.201.1.100,2:10.201.2.101,3:10.201.3.102"
    host_ip             = "10.201.2.100"
    kafka_mem           = "2048"
    kafka_zoo           = "10.201.1.100:2181,10.201.2.101:2181,10.201.3.102:2181"
  }
}



