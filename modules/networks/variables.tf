variable "network_context" {
  type = object({
    context = any
  })
}

variable "create_subnet" {
  type = bool
  default = false
}

variable "ip_range" {
  type = string
  default = "10.0.0.0/8"
}
variable "subnet_ip_range" {
  type = string
  default = "10.0.1.0/24"
}
variable "subnet_network_zone" {
  type = string
  default = "eu-central"
}
variable "hcloud_provider" {
  type = any
  default = null
}