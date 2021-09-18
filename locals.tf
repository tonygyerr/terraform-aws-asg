locals {
  environment_name = data.null_data_source.environment.outputs["SDLC"]
  tf_workspace     = lookup(var.deploy_env_map, lower(terraform.workspace), lower(terraform.workspace))
  name_prefix      = var.name_prefix != "" ? format("%s-", var.name_prefix) : ""
}