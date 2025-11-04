module "name" {
  source     = "cloudposse/label/null"
  version    = "v0.25.0"
  context    = var.application_name_context.context
  attributes = [var.stage, var.application_name]
}

data "template_file" "compose" {
  count    = var.docker_compose_template != "" ? 1 : 0
  template = file(var.docker_compose_template)
  vars = {
    stage      = var.stage
    hosts_yaml = local.hosts_yaml
    base_domain = local.base_domain
  }
}

locals {
  content = var.docker_compose_template != "" ? data.template_file.compose[0].rendered : var.docker_compose_content
}

resource "portainer_stack" "application_depending" {
  count              = var.wait_for_inwx_entries ? 1 : 0
  deployment_type    = var.deployment_mode
  endpoint_id        = var.endpoint_id
  method             = "string"
  name               = module.name.id
  stack_file_content = local.content
  depends_on         = [time_sleep.wait_30_seconds[0]]
}

resource "portainer_stack" "application_immediate" {
  count              = var.wait_for_inwx_entries ? 0 : 1
  deployment_type    = var.deployment_mode
  endpoint_id        = var.endpoint_id
  method             = "string"
  name               = module.name.id
  stack_file_content = local.content
}
