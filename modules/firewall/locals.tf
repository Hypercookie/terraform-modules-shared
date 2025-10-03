locals {
  all_subnets = [
    "0.0.0.0/0",
    "::/0"
  ]
  local_only = var.subnets.*.ip_range
}