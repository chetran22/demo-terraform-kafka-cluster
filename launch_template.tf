resource "aws_launch_template" "default-lt" {
  name          = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-lt"
  image_id      = "${lookup(var.ami_mapping, local.product_name_region)}"
  instance_type = "${lookup(var.instance_type_mapping, var.product_name)}"
  key_name      = var.key_name_mapping[var.account_env]

  vpc_security_group_ids = [aws_security_group.default-sg.id]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.root_volume_size
      volume_type = var.root_volume_type
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.account}-${var.product_code}-${var.environment}-${var.product_name}-lt"
    }
  }

  user_data = data.template_cloudinit_config.cloudinit.rendered
}
