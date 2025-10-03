output "ipv4" {
  value = hcloud_primary_ip.ipv4
}
output "ipv6" {
  value = try(hcloud_primary_ip.ipv6, null)
}