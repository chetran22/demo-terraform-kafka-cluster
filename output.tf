#output "ami" {
#  value = "${lookup(var.ami_mapping, local.product_name_region)}"
#}
#
#output "ec2_instance_count" {
#  value = "${lookup(var.instance_count_mapping, var.product_name)}"
#}
#
#output "vpc" {
#  description = "vpc"
#  value       = data.aws_vpc.vpc_id.id
#}
#
#output "subnets" {
#  description = "subnet"
#  value = [data.aws_subnets.subnets.ids]
#}
#
#output "available_zones" {
#  value = slice(data.aws_availability_zones.available_azs.names, 0, 3)
#}
#
#output "security_groups" {
#  value = [aws_security_group.default-sg.id]
#}
#
#output "private-ips" {
#  value = data.aws_instances.nodes.private_ips
#}
#
#output "instance-ids" {
#  value = data.aws_instances.nodes.ids
#}
#
#output "dns_load_balancer" {
#  value = data.aws_lb.dns_load_balancer.dns_name
#}
#
#output "ports_mapping" {
#  value = {
#    for k, v in  var.product_ports_mapping[var.product_name] : k => v
#  }
#}
#
#output "default-lb-tg" {
#  value = aws_lb_target_group.default-lb-tg
#}
#
#output "default-lb-listener-tcp" {
#  value = aws_lb_listener.default-lb-listener-tcp
#}
#
output "dns_setting_for_1-dns" {
  value = {
      product_name = "${var.product_name}"
      load_balancer = data.aws_lb.dns_load_balancer.dns_name
      IPs = data.aws_instances.nodes.public_ips
  }
}
