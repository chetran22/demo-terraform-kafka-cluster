data "aws_vpc" "vpc_id" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_id.id]
  }

  tags = {
    Name = var.subnet_name
  }
}

data "template_file" "cloudinit" {
  template = file("cloud-init.yaml")
  vars = {
    product_name = var.product_name
  }
}

data "template_cloudinit_config" "cloudinit" {
  base64_encode = true
  part {
    content = data.template_file.cloudinit.rendered
  }
}

data "aws_availability_zones" "available_azs" {
  state = "available"
}

data "aws_lb" "dns_load_balancer" {
  depends_on = [aws_lb.default-lb]
  name = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-lb"
}

data "aws_instances" "nodes" {
  depends_on = [aws_autoscaling_group.default-asg]
  instance_tags = {
    Name = aws_autoscaling_group.default-asg.id
  }
}
