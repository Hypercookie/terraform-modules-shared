locals {
  resource_pairs = setproduct(var.stages, var.resources)
  pairs_map = {
    for pair in local.resource_pairs :
    "${pair[0]}-${pair[1]}" => {
      stage = pair[0]
      name  = pair[1]
    }
  }
}

module "base" {
  source    = "cloudposse/label/null"
  version   = "v0.25.0"
  namespace = var.namespace
}

module "base-stage" {
  source   = "cloudposse/label/null"
  for_each = { for s in var.stages : s => s }
  context  = module.base.context
  version  = "v0.25.0"
  stage    = each.value
}

module "base-resources" {
  source   = "cloudposse/label/null"
  for_each = local.pairs_map
  context  = module.base-stage[each.value.stage].context
  version  = "v0.25.0"
  name     = each.value.name
}
