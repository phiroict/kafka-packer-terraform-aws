data "template_file" "kafka_config_pu0"{
  template = "${file("${path.module}/kafka_zookeeper.tpl")}"

  vars ={
    id = "1"
    zk_mem= "512"
    zookeepers_sequence = "1:0.0.0.0,2:10.201.2.100,3:10.201.3.100"
    host_ip = "10.201.1.100"
    kafka_mem= "2048"
    kafka_zoo = "10.201.1.100:2181,10.201.2.100:2181,10.201.3.100:2181"
  }
}

data "template_file" "kafka_config_pr0"{
  template = "${file("${path.module}/kafka_zookeeper.tpl")}"
  vars ={
    id = "2"
    zk_mem= "512"
    zookeepers_sequence = "1:10.201.1.100,2:0.0.0.0,3:10.201.3.100"
    host_ip = "10.201.2.100"
    kafka_mem= "2048"
    kafka_zoo = "10.201.1.100:2181,10.201.2.100:2181,10.201.3.100:2181"

  }
}

data "template_file" "kafka_config_pr1"{
  template = "${file("${path.module}/kafka_zookeeper.tpl")}"
  vars ={
    id = "3"
    zk_mem= "512"
    zookeepers_sequence = "1:10.201.1.100,2:10.201.2.100,3:0.0.0.0"
    host_ip = "10.201.3.100"
    kafka_mem= "2048"
    kafka_zoo = "10.201.1.100:2181,10.201.2.100:2181,10.201.3.100:2181"

  }
}