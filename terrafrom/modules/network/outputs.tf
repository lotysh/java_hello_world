output "region" {
  value = "${var.region}"
}

output "environment_id" {
  value = "${var.environment_id}"
}

output "environment_name" {
  value = "${var.environment_name}"
}

output "vpc_cidr" {
  value = "${var.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${aws_subnet.public.*.id}"
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "zones" {
  value = "${var.zones}"
}

output "nat_elastic_ips" {
  value = ["${aws_instance.nat.*.public_ip}"]
}

output "nat_private_ips" {
  value = ["${aws_instance.nat.*.private_ip}"]
}

output "public_subnet_route_ids" {
  value = ["${aws_route_table.public.*.id}"]
}

output "private_subnet_route_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "vpc_zone_identifier" {
  value = ["${aws_subnet.private.*.id}"]
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
