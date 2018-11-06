// public routing
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.environment_name} Public Routes"
    Environment = "${var.environment_id}"
  }
}
resource "aws_route" "public_route" {
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gw.id}"
}
resource "aws_route_table_association" "public" {
  count = "${length(var.zones)}"
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
}

// private routing
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  count = "${length(var.zones)}"

  tags {
    Name = "${var.environment_name} Private Routes"
    Environment = "${var.environment_id}"
  }
}
resource "aws_route" "private_route" {
  count = "${length(var.zones)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
}
resource "aws_route_table_association" "private" {
  count = "${length(var.zones)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
}