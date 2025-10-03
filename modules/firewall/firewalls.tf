module "firewall-https" {
  source     = "cloudposse/label/null"
  version    = "v0.25.0"
  context    = var.firewall_context
  attributes = ["https"]
}
module "firewall-ssh" {
  source     = "cloudposse/label/null"
  version    = "v0.25.0"
  context    = var.firewall_context
  attributes = ["ssh"]
}
module "firewall-ping" {
  source     = "cloudposse/label/null"
  version    = "v0.25.0"
  context    = var.firewall_context
  attributes = ["ping"]
}

resource "hcloud_firewall" "https" {
  name  = module.firewall-https.id
  count = var.create_https_firewall ? 1 : 0
  rule {
    direction   = "in"
    protocol    = "tcp"
    source_ips  = local.all_subnets
    port        = 80
    description = "http traffic"
  }
  rule {
    direction   = "in"
    protocol    = "tcp"
    source_ips  = local.all_subnets
    port        = 443
    description = "https traffic"
  }
}
resource "hcloud_firewall" "ssh" {
  name  = module.firewall-ssh.id
  count = var.create_ssh_firewall ? 1 : 0

  dynamic "rule" {
    for_each = var.use_endless_ssh ? [22, 5555] : [22]

    content {
      direction   = "in"
      protocol    = "tcp"
      source_ips  = local.all_subnets
      port        = rule.value
      description = "ssh traffic on port ${rule.value}"
    }
  }
}
resource "hcloud_firewall" "ping" {
  name  = module.firewall-ping.id
  count = var.create_ping_firewall ? 1 : 0
  rule {
    direction   = "in"
    protocol    = "icmp"
    source_ips  = local.all_subnets
    description = "ping"
  }
}

