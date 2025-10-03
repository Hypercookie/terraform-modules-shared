variable "hcloud_token" {
  sensitive = true
  type = string
}
variable "generate_ipv6" {
  default = true
  type = bool
}
variable "datacenter" {
  default = null
  type = string
}
variable "ip_context" {
  type = object({
    context = any
  })
}