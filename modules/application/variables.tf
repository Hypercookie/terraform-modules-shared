variable "application_name" {
  type = string
}

variable "application_name_context" {
  type = object({
    context = any
  })
}

variable "docker_compose_content" {
  type = string
}

variable "endpoint_ipv4" {
  type = string
}
variable "endpoint_ipv6" {
  type = string
}

variable "inwx_provider" {
  type = any
  default = null
}

variable "ipv6_support" {
type = bool
  default = true
}

variable "portainer_provider" {
  type = any
  default = null
}

variable "base_domain" {
  type = string
}
variable "subdomains" {
  type = list(string)
}

variable "create_inwx_entries" {
  type = bool
  default = true
}
variable "wait_for_inwx_entries" {
  type = bool
  default = true
}
variable "deployment_mode" {
  type = string
  default = "swarm"
}
variable "endpoint_id" {
  type = number
  default = 1
}
