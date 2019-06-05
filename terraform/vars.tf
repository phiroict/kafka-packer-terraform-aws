variable "base_kafka_image_ami" {
  type = "string"
  default = "ami-0f6f525461ca6509b"
}

variable "region" {
  type = "string"
  default = "ap-southeast-2"
}

variable "instance_type" {
  type = "string"
  default = "m4.large"
}

variable "kafka_exp_tags" {
  type = "map"
  default = {
    Author = "Philip Rodrigues"
    State = "Experimental"
    ExpiresAt = "20190625"
    Department = "CloudOps"
    Description = "Experimental_kafka_cluster_instance"
  }
}

variable "ip_allow_access_ip" {
  type = "string"
  default = "111.69.226.95/32"
}

variable "environment_tg" {
  type = "string"
  default = "not_set"
}