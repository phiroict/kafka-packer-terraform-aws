variable "base_kafka_image_aim" {
  type = "string"
  default = "ami-01913f6789036f2c3"
}

variable "region" {
  type = "string"
  default = "ap-southeast-2"
}

variable "instance_type" {
  type = "string"
  default = "m4.large"
}