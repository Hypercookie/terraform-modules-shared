output "all_subnets" {
  value = local.all_subnets
}
output "local_subnets" {
  value = local.local_only
}

output "https_firewall_id" {
  value = hcloud_firewall.https.id
}
output "ssh_firewall_id" {
  value = hcloud_firewall.ssh.id
}
output "ping_firewall_id" {
  value = hcloud_firewall.ping.id
}