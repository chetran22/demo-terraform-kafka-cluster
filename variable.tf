variable "aws_region" {}
variable "aws_profile" {}

variable "product_name" {}
variable "product_ports_mapping" {
  default = {
    "cc" = {
      "cc9021" = "9021"
      "cc9100" = "9100" # node-exporter
    }
    "kf" = {
      "kf8081" = "8081"
      "kf8082" = "8082"
      "kf8085" = "8085"
      "kf9091" = "9091"
      "kf9093" = "9093"
      "kf9100" = "9100" # node-exporter
    }
    "wk" = {
      "wk8083" = "8083"
      "wk9100" = "9100" # node-exporter
      
    }
    "zk" = {
      "zk2181" = "2181"
      "zk9100" = "9100" # node-exporter
    }
  }
}

variable "instance_type_mapping" {
  description = "mapping of instance type based on component"
  default = {
    "cc" = "t4g.nano"
    "kf" = "t4g.nano"
    "wk" = "t4g.nano"
    "zk" = "t4g.nano"
  }
}

variable "key_name_mapping" {
  default = {
    "dev" = "adarasoft-dev"
    "prod" = "adarasoft-prod"
  }
}

variable "instance_count_mapping" {
  default = {
    "kf" = 2
    "zk" = 3
    "wk" = 1
    "cc" = 1
  }
}

variable "vpc_name" {}
variable "subnet_name" {}
variable "account" {
  default = "ada"
}
variable "account_env" {}

variable "environment" {}

variable "product_code" {
  default = "kafka"
}

variable "iac_repo" {
  default = "https://git.adarasoft.io/kafka-engineering/kafka-cluster/terraform.git"
}

variable "domain" {
  default = "kafka.adarasoft.io"
}

variable "ami_mapping" {
  description = "mapping of AMIs"
  default = {
    "cc.use1" = "ami-03c5cc3d1425c6d34" # Amazon Linux 2 AMI 2.0.20221103.3 x86_64 HVM gp2
    "kf.use1" = "ami-03c5cc3d1425c6d34" # Amazon Linux 2 AMI 2.0.20221103.3 x86_64 HVM gp2
    "wk.use1" = "ami-03c5cc3d1425c6d34" # Amazon Linux 2 AMI 2.0.20221103.3 x86_64 HVM gp2
    "zk.use1" = "ami-03c5cc3d1425c6d34" # Amazon Linux 2 AMI 2.0.20221103.3 x86_64 HVM gp2
  }
}

variable "root_volume_size" {
  default = 200
}

variable "root_volume_type" {
  default = "gp3"
}

variable "delete_on_termination" {
  default = true
}
