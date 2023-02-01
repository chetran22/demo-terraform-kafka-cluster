resource "aws_lb" "default-lb" {
  name                             = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-lb"
  internal                         = true
  load_balancer_type               = "network"
  subnets                          = data.aws_subnets.subnets.ids
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "default-lb-tg" {
  for_each = (var.product_ports_mapping[var.product_name])

  port     = each.value
  protocol = "TCP"
  vpc_id   = data.aws_vpc.vpc_id.id

  depends_on = [aws_lb.default-lb]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "default-lb-listener-tcp" {
  for_each = (var.product_ports_mapping[var.product_name])

  load_balancer_arn = aws_lb.default-lb.arn
  port              = each.value
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default-lb-tg[each.key].arn

  }
}
