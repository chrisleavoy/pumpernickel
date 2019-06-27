variable "aws_weight" {
  default = 10
  description = "Proportional weight of DNS answers to route to AWS"
}

variable "gcp_weight" {
  default = 0
  description = "Proportional weight of DNS answers to route to GCP"
}

variable "fqdn" {
  default     = "pumpernickel.sdk.ca"
  description = "Fully qualified domain name of wordpress domain for DNS and healthchecks"
}

variable "aws_elb_cname" {
  default     = "a3870a59a987d11e99860125de9ecf39-1304849853.us-east-1.elb.amazonaws.com"
  description = "cname of the AWS ELB pointed towards our Kubernetes cluster"
}

variable "aws_elb_zone_id" {
  default     = "Z35SXDOTRQ7X7K"
  description = "ZoneID of the cname for the AWS ELB, required to establish an alias record in Route53"
}

variable "route53_zone_id" {
  # sdk.ca
  default     = "Z1PUYMDM0I5TL4"
  description = "ZoneID of the domain to add our records into"
}

variable "gcp_external_ip" {
  default     = "34.73.213.253"
  description = "Static External/public IP in GCP pointed towards our Kubernetes cluster"
}
