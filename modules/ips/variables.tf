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
variable "hcloud_provider" {
  type = any
  default = null
}