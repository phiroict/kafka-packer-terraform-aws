variable "base_kafka_image_ami" {
  type    = string
  default = "ami-03b6907c6bb88e324"
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "instance_type" {
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

variable "ip_allow_access_ip" {
  type    = string
  default = "115.189.85.152/32"
}

variable "environment_tg" {
  type    = string
  default = "not_set"
}

