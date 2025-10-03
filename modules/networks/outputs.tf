output "network" {
  value = hcloud_network.default
}
output "subnet" {
  value = try(hcloud_network_subnet.sub[0], null)
}