locals {
  fqdns = [for x in var.subdomains: join(".", [var.base_domain, x]) ]
}
