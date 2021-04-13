data "aws_availability_zones" "main" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "api" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet_ids" "api" {
  vpc_id =  data.aws_vpc.api
}

data "aws_subnet" "private" {                                   
  count = length(data.aws_subnet_ids.private.ids)               
  id    = local.subnet_ids_list[count.index]                        
} 

data "null_data_source" "environment" {
  inputs = "${map(
    "SDLC",
    lower(
      element(
        split("-", data.aws_iam_account_alias.current.account_alias),
        length(split("-", data.aws_iam_account_alias.current.account_alias)) - 1
    ))
  )}"
}