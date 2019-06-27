resource "aws_route53_health_check" "pumpernickel-aws" {
  fqdn              = "${var.aws_elb_cname}"
  port              = 80
  type              = "HTTP"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Name = "pumpernickel-aws"
  }
}

resource "aws_route53_health_check" "pumpernickel-gcp" {
  fqdn              = "${var.fqdn}"
  ip_address        = "${var.gcp_external_ip}"
  port              = 80
  type              = "HTTP"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Name = "pumpernickel-gcp"
  }
}

resource "aws_route53_record" "pumpernickel-aws" {
  zone_id         = "${var.route53_zone_id}"
  name            = "${var.fqdn}"
  type            = "A"
  set_identifier  = "pumpernickel-aws"
  health_check_id = "${aws_route53_health_check.pumpernickel-aws.id}"

  alias {
    name                   = "dualstack.${var.aws_elb_cname}."
    zone_id                = "${var.aws_elb_zone_id}"
    evaluate_target_health = true
  }

  weighted_routing_policy {
    weight = "${var.aws_weight}"
  }
}

resource "aws_route53_record" "pumpernickel-gcp" {
  zone_id         = "${var.route53_zone_id}"
  name            = "${var.fqdn}"
  type            = "A"
  ttl             = "60"
  records         = ["${var.gcp_external_ip}"]
  set_identifier  = "pumpernickel-gcp"
  health_check_id = "${aws_route53_health_check.pumpernickel-gcp.id}"

  weighted_routing_policy {
    weight = "${var.gcp_weight}"
  }
}
