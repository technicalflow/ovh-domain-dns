terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~>0.34"
    }
  }
}

provider "ovh" {
  endpoint           = var.dns_ovh_endpoint
  application_key    = var.dns_ovh_application_key
  application_secret = var.dns_ovh_application_secret
  consumer_key       = var.dns_ovh_consumer_key
}

# data "ovh_me" "ovh" {}

data "local_file" "readip" {
  filename = "ip.txt"
}

data "http" "iptest" {
  url = "http://icanhazip.com"
  # request_body = "request body"
  # method = "GET"
  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

resource "ovh_domain_zone_record" "testip" {
  zone      = var.domain_name
  subdomain = null
  fieldtype = "A"
  ttl       = "60"
  target    = data.http.iptest.response_body
}

resource "local_file" "name" {
  filename = "ip.txt"
  file_permission = 0755
  content = data.http.iptest.response_body
}

#OVH variables
variable "domain_name" {
  type    = string
  default = "example.com"
}

variable "dns_ovh_endpoint" {
  type = string
}

variable "dns_ovh_application_key" {
  type = string
}

variable "dns_ovh_application_secret" {
  type = string
}

variable "dns_ovh_consumer_key" {
  type = string
}

output "id" {
  value = ovh_domain_zone_record.testip.id
}
