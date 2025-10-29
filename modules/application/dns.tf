resource "inwx_nameserver_record" "ipv4_entries" {
  for_each = var.create_inwx_entries ? toset(local.fqdns) : toset([])
  content = var.endpoint_ipv4
  name = each.value
  domain  = var.base_domain
  type    = "A"
}

resource "inwx_nameserver_record" "ipv6_entries" {
  for_each = var.create_inwx_entries && var.ipv6_support ? toset(local.fqdns) : toset([])
  content = var.endpoint_ipv6
  name = each.value
  domain  = var.base_domain
  type    = "AAAA"
}

data "external" "wait_for_dns" {
  program = ["bash", "${path.module}/scripts/wait-for-dns.sh"]
  for_each = var.wait_for_inwx_entries ? toset(local.fqdns) : toset([])
  query = {
    fqdn         = each.value
    expected_ipv4 = var.endpoint_ipv4
    expected_ipv6 = var.ipv6_support ? var.endpoint_ipv6 : ""
  }
}
