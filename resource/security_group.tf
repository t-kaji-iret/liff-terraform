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
    }
  ]
}