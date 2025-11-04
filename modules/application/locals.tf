locals {
  subdomains = var.stage != "" ? [for s in var.subdomains : join(".", [var.stage, s])] : var.subdomains
  fqdns = [
    for x in var.subdomains : join(".",
      var.stage != "" ? [x, var.stage, var.base_domain] : [x, var.base_domain]
    )
  ]
  hosts_yaml = yamlencode(join(" || ", [for h in local.fqdns : format("Host(`%s`)", h)]))
}
output "hosts" {
  value = local.fqdns
}
