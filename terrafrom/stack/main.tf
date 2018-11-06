module "network" {
  source = "../modules/network"

  environment_id   = "${var.environment_id}"
  environment_name = "${var.environment_name}"
  region           = "${var.region}"
  vpc_cidr         = "${var.vpc_cidr}"
  nat_ami          = "${var.nat_ami}"
}

module "structure" {
  source = "../modules/structure"

  vpc_zone_identifier = ["${module.network.vpc_zone_identifier}"]
  vpc_id              = "${module.network.vpc_id}"

  #   environment_name = "${var.environment_name}"
  #   region           = "${var.region}"
  #   vpc_cidr         = "${var.vpc_cidr}"
  #   nat_ami          = "${var.nat_ami}"
}
