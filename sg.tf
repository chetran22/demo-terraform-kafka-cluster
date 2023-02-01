resource "aws_security_group" "default-sg" {
  name   = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-sg"
  vpc_id = data.aws_vpc.vpc_id.id

  tags = {
    Name = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-lt"
  }
}

resource "aws_security_group_rule" "default-sg-egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default-sg.id
}

resource "aws_security_group_rule" "default-sg-ingress_100" {
  type        = "ingress"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default-sg.id
}

resource "aws_security_group_rule" "default-sg-ingress_122" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default-sg.id
}

##### zk:tcp:2181; cc:http:9021; wk:tcp:8083; kf:tcp:8081,tcp:8082:rest,tcp:8085:rest-ssl,tcp:9091,tcp:9093; ksql:tcp:8088; sr:tcp:8081

resource "aws_security_group_rule" "default-sg-ingress" {
  for_each    = (var.product_ports_mapping[var.product_name])
  type        = "ingress"
  from_port   = each.value
  to_port     = each.value
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default-sg.id
}
