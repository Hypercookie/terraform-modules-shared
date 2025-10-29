module "name" {
  source  = "cloudposse/label/null"
  version = "v0.25.0"
  context = var.application_name_context.context
  attributes = [var.application_name]
}



resource "portainer_stack" "application_depending" {
  count = var.wait_for_inwx_entries && var.create_inwx_entries ? 1 : 0
  deployment_type      = var.deployment_mode
  endpoint_id          = var.endpoint_id
  method               = "string"
  name                 = module.name.id
  stack_file_content   = var.docker_compose_content
  depends_on = [data.external.wait_for_dns]
}

resource "portainer_stack" "application_immediate" {
  count = var.wait_for_inwx_entries ? 0 : 1
  deployment_type      = var.deployment_mode
  endpoint_id          = var.endpoint_id
  method               = "string"
  name                 = module.name.id
  stack_file_content   = var.docker_compose_content
  depends_on = [data.external.wait_for_dns]
}
