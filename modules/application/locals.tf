locals {
  concat_subdomains = concat(local.subdomains, var.extra_subdomains)
  subdomains = var.stage != "" ? [for s in var.subdomains : join(".", [var.stage, s])] : var.subdomains
  fqdns = [
    for x in var.subdomains : join(".",
      var.stage != "" ? [x, var.stage, var.base_domain] : [x, var.base_domain]
    )
  ]
  base_domain = var.stage != "" ? "${var.stage}.${var.base_domain}" : var.base_domain
  hosts_yaml = join(" || ", [for h in local.fqdns : format("Host(`%s`)", h)])
}
output "hosts" {
  value = local.fqdns
}
