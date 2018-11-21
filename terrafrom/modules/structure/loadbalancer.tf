resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = ["${var.vpc_zone_identifier}"]

  # Run the ELB in TCP passthrough mode
  listener {
    lb_port           = "${var.lb_port}"
    lb_protocol       = "HTTP"
    instance_port     = "${var.ec2_port}"
    instance_protocol = "HTTP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/sparkjava-hello-world-1.0/hello"
    interval            = 30
  }

  tags {
    Name = "${var.elb_name}"
  }
}

resource "aws_autoscaling_attachment" "lb" {
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
  elb                    = "${aws_elb.elb.id}"
}

resource "aws_security_group" "elb" {
  name        = "${var.elb_name}"
  description = "Security group for the ${var.elb_name} ELB"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "allow_inbound" {
  type              = "ingress"
  from_port         = "${var.lb_port}"
  to_port           = "${var.lb_port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

