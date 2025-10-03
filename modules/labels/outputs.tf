output "resources_by_stage" {
  description = "Nested map of resources grouped by stage"
  value = {
    for pair, mod in module.base-resources :
    local.pairs_map[pair].stage => {
      for inner_pair, inner_mod in module.base-resources :
      local.pairs_map[inner_pair].name => {
        context = inner_mod.context
      }
      if local.pairs_map[inner_pair].stage == local.pairs_map[pair].stage
    }
  }
}

output "resources" {
  description = "Flat map of all resources by pair key (stage-resource)"
  value = {
    for pair, mod in module.base-resources :
    pair => mod.context
  }
}