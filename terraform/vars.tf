variable "base_kafka_image_aim" {
  type = "string"
  default = "ami-03fd73a66cf574a36"
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
    Name = "Experimental_kafka_cluster_instance"
  }
}