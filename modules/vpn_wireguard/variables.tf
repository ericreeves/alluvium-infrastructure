variable "region" {
  type = string
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The machine type to launch, some machines may offer higher throughput for higher use cases."
}

variable "ssh_public_key" {
  description = "SSH Public Key"
}
variable "asg_min_size" {
  default     = 1
  description = "We may want more than one machine in a scaling group, but 1 is recommended."
}

variable "asg_desired_capacity" {
  default     = 1
  description = "We may want more than one machine in a scaling group, but 1 is recommended."
}

variable "asg_max_size" {
  default     = 1
  description = "We may want more than one machine in a scaling group, but 1 is recommended."
}

variable "vpc_id" {
  description = "The VPC ID in which Terraform will launch the resources."
}

variable "public_subnets_id" {
  type        = list(string)
  description = "A list of subnets for the Autoscaling Group to use for launching instances. May be a single subnet, but it must be an element in a list."
}

variable "wg_clients" {
  type        = list(object({ friendly_name = string, public_key = string, client_ip = string }))
  description = "List of client objects with IP and public key. See Usage in README for details."
}

variable "wg_server_net" {
  description = "IP range for vpn server - make sure your Client ips are in this range but not the specific ip i.e. not .1"
}

variable "wg_server_port" {
  default     = 51820
  description = "Port for the vpn server."
}

variable "wg_persistent_keepalive" {
  default     = 10
  description = "Persistent Keepalive - useful for helping connection stability over NATs."
}

variable "use_eip" {
  type        = bool
  default     = false
  description = "Whether to enable Elastic IP switching code in user-data on wg server startup. If true, eip_id must also be set to the ID of the Elastic IP."
}

variable "use_ssm" {
  type        = bool
  default     = false
  description = "Whether to use SSM to store Wireguard Server private key."
}

variable "target_group_arns" {
  type        = list(string)
  default     = null
  description = "Running a scaling group behind an LB requires this variable, default null means it won't be included if not set."
}

variable "environment" {
  description = "The name of environment for WireGuard. Used to differentiate multiple deployments."
}

variable "wg_server_private_key" {
  type        = string
  default     = null
  description = "WG server private key."
}

variable "ami_id" {
  default     = null # we check for this and use a data provider since we can't use it here
  description = "The AWS AMI to use for the WG server, defaults to the latest Ubuntu 20.04 AMI if not specified."
}

variable "wg_server_interface" {
  default     = "eth0"
  description = "The default interface to forward network traffic to."
}

variable "prometheus_server_ip" {
  type        = string
  default     = null
  description = "Prometheus server IP."
}

variable "use_route53" {
  type        = bool
  default     = false
  description = "Whether to use SSM to store Wireguard Server private key."
}

variable "route53_hosted_zone_id" {
  type        = string
  default     = null
  description = "Route53 Hosted zone ID."
}

variable "route53_domain_name" {
  type        = string
  default     = null
  description = "Route53 Domain (ex: hashicorp.com)"
}

variable "route53_geo" {
  type        = any
  default     = null
  description = "Route53 Geolocation config."
}

variable "home_cidr" {
  description = "Home Network CIDR Range"
}

variable "public_rtb_id" {
  description = "Public Route Table ID"
}

variable "private_rtb_id" {
  description = "Private Route Table ID"
}

variable "default_rtb_id" {
  description = "Default Route Table ID"
}
