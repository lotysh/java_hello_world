resource "aws_autoscaling_group" "autoscaling_group" {
  name                 = "${var.cluster_name}"
  launch_configuration = "${aws_launch_configuration.launch_configuration.name}"
  vpc_zone_identifier  = ["${var.vpc_zone_identifier}"]

  # Use a fixed-size cluster
  min_size                  = "${var.cluster_size}"
  max_size                  = "${var.cluster_size}"
  desired_capacity          = "${var.cluster_size}"
  health_check_type         = "${var.health_check_type}"
  health_check_grace_period = 15

  tags = [
    {
      key                 = "Name"
      value               = "Server-${var.cluster_name}"
      propagate_at_launch = true
    },
    {
      key                 = "environmentName"
      value               = "test"
      propagate_at_launch = true
    },
  ]
}

resource "aws_launch_configuration" "launch_configuration" {
  name          = "${var.cluster_name}"
  image_id      = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  security_groups = ["${aws_security_group.autoscaling_security_group.id}"]
}

resource "aws_security_group" "autoscaling_security_group" {
  name_prefix = "${var.cluster_name}"
  description = "Security group for the ${var.cluster_name} launch configuration"

  vpc_id = "${var.vpc_id}"

  tags {
    Name            = "${var.cluster_name}"
    environmentName = "environmentName:test"
  }
}

resource "aws_security_group_rule" "allow_all_inbound_port_8080" {
  type              = "ingress"
  from_port         = "${var.ec2_port}"
  to_port           = "${var.ec2_port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.autoscaling_security_group.id}"
}

resource "aws_security_group_rule" "allow_all_outbound_asg" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.autoscaling_security_group.id}"
}
