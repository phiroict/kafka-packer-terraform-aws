resource "aws_vpc" "exp_kafka_vpc" {
  cidr_block           = "10.201.0.0/16"
  enable_dns_hostnames = true
  tags = merge(
    var.kafka_exp_tags,
    {
      "Name" = "PhiRo_Kafka_VPC_Experimental"
    },
  )
}

resource "aws_subnet" "exp_kafka-subnet-se-2a" {
  cidr_block = "10.201.1.0/24"
  vpc_id     = aws_vpc.exp_kafka_vpc.id
  tags = merge(
    var.kafka_exp_tags,
    {
      "Name" = "PhiRo_Kafka_Subnet0 se-2a_Experimental"
    },
  )
  availability_zone = "ap-southeast-2a"
}

resource "aws_subnet" "exp_kafka-subnet-se-2b" {
  cidr_block = "10.201.2.0/24"
  vpc_id     = aws_vpc.exp_kafka_vpc.id
  tags = merge(
    var.kafka_exp_tags,
    {
      "Name" = "PhiRo_Kafka_Subnet1_se-2b Experimental"
    },
  )
  availability_zone = "ap-southeast-2b"
}

resource "aws_subnet" "exp_kafka-subnet-se-2c" {
  cidr_block = "10.201.3.0/24"
  vpc_id     = aws_vpc.exp_kafka_vpc.id
  tags = merge(
    var.kafka_exp_tags,
    {
      "Name" = "PhiRo_Kafka_Subnet0_se-2c Experimental"
    },
  )
  availability_zone = "ap-southeast-2c"
}

resource "aws_eip" "kafka_ip_address" {
  instance = aws_instance.kafka_instance_public_broker.id
  vpc      = true
  tags = merge(
    var.kafka_exp_tags,
    {
      "Name" = "PhiRo_Kafka_ElasticIP_Experimental"
    },
  )
}

resource "aws_internet_gateway" "kafka_cluster_internet_gateway" {
  vpc_id = aws_vpc.exp_kafka_vpc.id
  tags = merge(
    var.kafka_exp_tags,
    {
      "Name" = "PhiRo_Kafka_IGW_Experimental"
    },
  )
}

resource "aws_default_route_table" "internet_router" {
  default_route_table_id = aws_vpc.exp_kafka_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kafka_cluster_internet_gateway.id
  }
  tags = merge(
    var.kafka_exp_tags,
    {
      "Name" = "PhiRo_Kafka Default_RouteTable_Experimental"
    },
  )
}

