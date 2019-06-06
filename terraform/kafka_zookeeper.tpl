#!/usr/bin/env bash
touch /tmp/bla
sudo zookeeper_config -E -S -i ${id} -m ${zk_mem}m -n ${zookeepers_sequence}
sudo kafka_config -a ${host_ip} -E -i ${id} -m ${kafka_mem}m -S -z ${kafka_zoo}