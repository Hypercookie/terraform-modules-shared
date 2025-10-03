module "ipv4" {
  source  = "cloudposse/label/null"
  version = "v0.25.0"
  context = var.ip_context.context
  attributes = ["ipv4"]
}
module "ipv6" {
  source  = "cloudposse/label/null"
  version = "v0.25.0"
  context = var.ip_context.context
  attributes = ["ipv6"]
}
resource "hcloud_primary_ip" "ipv4" {
  name          = module.ipv4.id
  assignee_type = "server"
  auto_delete   = false
  datacenter    = var.datacenter
  type          = "ipv4"
}
resource "hcloud_primary_ip" "ipv6" {
  assignee_type = "server"
  count         = var.generate_ipv6 ? 1 : 0
  auto_delete   = false
  type          = "ipv6"
  datacenter    = var.datacenter
  name          = module.ipv6.id
}