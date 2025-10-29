resource "inwx_nameserver_record" "ipv4_entries" {
  for_each = var.create_inwx_entries ? toset(var.subdomains) : toset([])
  content = var.endpoint_ipv4
  name = each.value
  domain  = var.base_domain
  type    = "A"
}

resource "inwx_nameserver_record" "ipv6_entries" {
  for_each = var.create_inwx_entries && var.ipv6_support ? toset(var.subdomains) : toset([])
  content = var.endpoint_ipv6
  name = each.value
  domain  = var.base_domain
  type    = "AAAA"
}

resource "dns_address_validation" "valid_v4" {
  for_each = var.create_inwx_entries ? toset(local.fqdns) : toset([])
  name = each.value
  addresses = [var.endpoint_ipv4]
}
