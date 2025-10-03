module "network" {
  source  = "cloudposse/label/null"
  version = "v0.25.0"
  context = var.network_context.context
  attributes = ["default"]
}

resource "hcloud_network" "default" {
  ip_range = var.ip_range
  name     = module.network.id
}
resource "hcloud_network_subnet" "sub" {
  count = var.create_subnet ? 1 : 0
  ip_range     = var.subnet_ip_range
  network_id   = hcloud_network.default.id
  network_zone = var.subnet_network_zone
  type         = "cloud"
}