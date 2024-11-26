#########################
# Security Group
#########################
// Lambda用のセキュリティグループ
module "lambda-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "gourmet-liff-app-lambda-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = ["all-all"]
}

// RDS用のセキュリティグループ
module "rds-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "gourmet-liff-app-rds-sg"
  vpc_id = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.lambda-sg.security_group_id
    },
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.ec2-sg.security_group_id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 2
}

// 踏み台EC2用のセキュリティグループ
module "ec2-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "gourmet-liff-app-ec2-sg"
  vpc_id = module.vpc.vpc_id

  computed_egress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.vpc-endpoint-sg.security_group_id
    },
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.rds-sg.security_group_id
    }
  ]

  number_of_computed_egress_with_source_security_group_id = 2
}

// VPCエンドポイント用のセキュリティグループ
module "vpc-endpoint-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "gourmet-liff-app-vpc-endpoint-sg"
  vpc_id = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.ec2-sg.security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.lambda-sg.security_group_id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 2
}