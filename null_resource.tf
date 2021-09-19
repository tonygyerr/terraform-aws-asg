resource "null_resource" "asg" {
  depends_on = [module.asg.autoscaling_group_id]

  provisioner "local-exec" {
    environment = {
      INSTANCE    = module.asg.autoscaling_group_id.*.id[0]
    }
    command = file(var.node_status_check_file)
  }
} 