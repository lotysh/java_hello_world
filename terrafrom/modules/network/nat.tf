// NAT instances - DEPRECATED, used only for SSH tunneling for Terraform provisioning
resource "aws_instance" "nat" {
  instance_type = "t2.micro"
  count = "${length(var.zones)}"
  availability_zone = "${element(var.zones, count.index)}"
  ami = "${var.nat_ami}"
  source_dest_check = false
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  associate_public_ip_address = true
  key_name      = "hello-world-instances"
  security_groups = ["${aws_security_group.default.id}"]
  lifecycle {
    ignore_changes = ["ami"]
  }

  tags {
    Name = "${var.environment_name} NAT Instance"
    Environment = "${var.environment_id}"
  }
}

// elastic IPs
resource "aws_eip" "nat" {
  count = "${length(var.zones)}"
  vpc = true
}

// attach managed NAT
resource "aws_nat_gateway" "nat" {
  count = "${length(var.zones)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"

  tags {
    Name = "${var.environment_name} NAT"
    Environment = "${var.environment_id}"
  }
}
