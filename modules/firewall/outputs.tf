output "all_subnets" {
  value = local.all_subnets
}
output "local_subnets" {
  value = local.local_only
}

output "https_firewall_id" {
  value = try(hcloud_firewall.https[0].id, null)
}
output "ssh_firewall_id" {
  value = try(hcloud_firewall.ssh[0].id, null)
}
output "ping_firewall_id" {
  value = try(hcloud_firewall.ping[0].id, null)
}