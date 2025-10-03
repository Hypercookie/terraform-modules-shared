variable "hcloud_token" {
  sensitive = true
  type      = string
}

variable "subnets" {
  type = list(object({
    ip_range = string
  }))
}

variable "create_https_firewall" {
  type    = bool
  default = false
}

variable "create_ssh_firewall" {
  type    = bool
  default = false
}

variable "create_ping_firewall" {
  type    = bool
  default = false
}

variable "use_endless_ssh" {
  type    = bool
  default = false
}

variable "firewall_context" {
  type = object({
    context = object({})
  })
}