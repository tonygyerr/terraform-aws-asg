##########
# management api
##########

- provision infrastructure for NAM using [Packer](https://packer.io) and [Terraform](https://www.terraform.io) on Amazon Web Services (AWS)

###############
# pre requisites
###############

- install git
- install packer
- install terraform
- AWS Key pair for Terraform provisioning or as required per EC2 Instance requirements
- AWS s3 bucket for remote terraform state file (tfstate)
- AWS Dynamo dB for tfstate table state lock 
- Cloud Team aee_mvp.sh to set aws session
- Digital Platform Team: Terraform Modules: vpc, sg 

##########
# dynamodb
##########

##########
# create terraform-api-nonprod-statelock
##########

aws dynamodb create-table --region us-east-1 --table-name terraform-api-prd-statelock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=20,WriteCapacityUnits=20

###########
# terraform 
###########

Terraform will be used to provision AWS infrastructure and resources for Web:
- Application Load Balancers (ALB)
- Auto Scaling Groups
- Data IAM
- ECR
- ECS
- EFS
- KMS
- RDS
- Output
- Security Groups
- Simple Notification Service (SNS)
- Simple Queue Service (SQS)
- Variables

```
  mvp api-prd
$ cd terraform
$ terraform get
$ terraform init
$ terraform plan
$ terraform apply

```
  destroy infrastructure only when needed
$ terraform destroy
```

### Example of Module Asg

module "asg" {
  source = "git::https://github.com/tonygyerr/terraform-aws-asg.git"

  app_name                = "my-app-name"
  ami                     = "ami-0742b4e673072066f"
  aws_key_name            = "my-app-key-app-server"
  instance_type           = "t2.xlarge"
  lb_prv_subnets          = ["10.0.0.144/28", "10.0.0.160/28", "10.0.0.176/28"]
  lb_subnet_ids           = ["subnet-***********","subnet-00cc***********","subnet-01f************"]
  userdata                = "userdata/userdata.sh" #data.template_file.user_data.rendered
  vpc_name                = "api-vpc"
  vpc_id                  = "vpc-**************"
  vpc_security_group_ids  = [module.api.alb_sg_id]
}