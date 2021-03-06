variable "env_name" {
  type = "string"
}

variable "project" {
  type = "string"
}

variable "region" {
  type    = "string"
  default = "us-central1"
}

variable "az1" {
  type = "map"

  default = {
    "us-central1" = "us-central1-a"
  }
}

variable "az2" {
  type = "map"

  default = {
    "us-central1" = "us-central1-b"
  }
}

variable "az3" {
  type = "map"

  default = {
    "us-central1" = "us-central1-c"
  }
}

variable "opsman_version" {
  type    = "string"
  default = "2.4"
}

variable "opsman_build" {
  type    = "string"
  default = "117"
}

variable "dns_suffix" {
  type = "string"
}

variable "dns_zone_name" {
  default = "paasify-zone"
}

variable "opsman_user" {
  type    = "string"
  default = "admin"
}

variable "pivnet_token" {
  type = "string"
}

variable "compute_instance_count" {
  type    = "string"
  default = "1"
}

variable "tiles" {
  type = "list"

  default = ["mysql", "rabbit", "scs", "metrics", "healthwatch"]
}

variable "wavefront_token" {
  type    = "string"
  default = ""
}

variable "auto_apply" {
  type    = "string"
  default = "1"
}