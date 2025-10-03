output "all_subnets" {
  value = local.all_subnets
}
output "local_subnets" {
  value = local.local_only
}

output "https_firewall" {
  value = try(hcloud_firewall.https[0], null)
}
output "ssh_firewall" {
  value = try(hcloud_firewall.ssh[0], null)
}
output "ping_firewall" {
  value = try(hcloud_firewall.ping[0], null)
}