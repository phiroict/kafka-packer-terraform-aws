variable "base_kafka_image_ami" {
  type    = string
  default = "ami-03b6907c6bb88e324"
  description = "This is the ami that is created by the packer process. Get this from the output of the process"
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "kafka_instance_type" {
  type    = string
  default = "m4.large"
}

variable "kafka_exp_tags" {
  type = map(string)
  default = {
    Author      = "Philip Rodrigues"
    State       = "Experimental"
    Department  = "CloudOps"
    Description = "Experimental_kafka_cluster_instance"
  }
}

variable "ip_allow_access_ip4" {
  type    = string
  default = "151.210.138.94/32"
  description = "Add initially your own ip4 address here"
}

variable "ip_allow_access_ip6" {
  type    = string
  default = "2406:e002:58b4:db01:92b1:1cff:fe65:6c80/128"
  description = "Add initially your own ip6 address here"
}

variable "environment_tg" {
  type    = string
  default = "not_set"
}

variable "core_ip_subnet" {
  type = string
  default = "10.201.2.%s"
}

variable "core_ip_subnet_start" {
  type = number
  default = 100
}

variable "kafka_cluster_size" {
  type = number
  default = 3
  description = "Number of kafka instances to create"
}

variable "build_bastion" {
  type = bool
  default = true
  description = "Create a jumphost to get to the kafka instances"
}

variable "aws_public_key" {
  type    = string
  default = ""
}
