output "resources_by_stage" {
  description = "Nested map of resources grouped by stage"
  value = {
    for stage in distinct([
      for pair in keys(module.base-resources) : local.pairs_map[pair].stage
    ]) :
    stage => {
      for pair, mod in module.base-resources :
      local.pairs_map[pair].name => {
        context = mod.context
      }
      if local.pairs_map[pair].stage == stage
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