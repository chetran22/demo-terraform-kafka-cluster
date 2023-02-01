locals {
  vpc_region          = split(".", var.vpc_name)[1]
  product_name_region = "${var.product_name}.${local.vpc_region}"
}
