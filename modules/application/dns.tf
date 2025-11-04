resource "inwx_nameserver_record" "ipv4_entries" {
  for_each = var.create_inwx_entries ? toset(local.concat_subdomains) : toset([])
  content  = var.endpoint_ipv4
  name     = each.value
  domain   = var.base_domain
  type     = "A"
}

resource "inwx_nameserver_record" "ipv6_entries" {
  for_each = var.create_inwx_entries && var.ipv6_support ? toset(local.concat_subdomains) : toset([])
  content  = var.endpoint_ipv6
  name     = each.value
  domain   = var.base_domain
  type     = "AAAA"
}

resource "time_sleep" "wait_30_seconds" {
  count           = var.wait_for_inwx_entries ? 1 : 0
  depends_on      = [inwx_nameserver_record.ipv4_entries[0]]
  create_duration = "30s"

}
