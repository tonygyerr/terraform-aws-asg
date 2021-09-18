data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# data "aws_iam_policy_document" "ecr" {
#   statement {
#     sid = "AllowECRPullByECS"

#     actions = [
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:BatchGetImage",
#     ]
#   }

#   # optionally enable ECR policies, if var.ecr_repositories is a non-empty list
#   count = "${signum(length(var.ecr_repositories))}"
# }

data "aws_iam_policy_document" "vpc_flow_assume" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "vpc_flow" {
  statement {
    sid       = "AllowReadAllLogGroups"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
  }

  statement {
    sid    = "AllowWriteToLogGroupVpcFlow"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["${aws_cloudwatch_log_group.flow_log.arn}"]
  }
}