resource "aws_autoscaling_group" "default-asg" {
  name                      = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-asg-ec2"
  min_size                  = "${lookup(var.instance_count_mapping, var.product_name)}"
  desired_capacity          = "${lookup(var.instance_count_mapping, var.product_name)}"
  max_size                  = "${lookup(var.instance_count_mapping, var.product_name)}"
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.default-lt.id
    version = "$Latest"
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = data.aws_subnets.subnets.ids

  lifecycle {
    ## CHANGE
    #  prevent_destroy       = true
    create_before_destroy = true
    # per https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
    ignore_changes = [load_balancers, target_group_arns]
  }
  tag {
    key                 = "Name"
    value               = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-asg-ec2"
    propagate_at_launch = true
  }

  tag {
    key                 = "ProductCode"
    value               = var.product_code
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "default-asg-attachment" {
  for_each =  (var.product_ports_mapping[var.product_name])

  autoscaling_group_name = aws_autoscaling_group.default-asg.id
  lb_target_group_arn    = aws_lb_target_group.default-lb-tg[each.key].arn
}
