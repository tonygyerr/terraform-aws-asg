data "template_file" "user_data" {
  template = file("${path.module}/${var.userdata}")

  vars = {
      image_name = var.image_name
      region = var.aws_region
  }
}