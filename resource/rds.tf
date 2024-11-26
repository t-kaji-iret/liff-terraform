#########################
# RDS
#########################
module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "gourmet-liff-app-db"

  engine            = "mysql"
  engine_version    = "8.0.39"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = data.aws_ssm_parameter.db_name.value
  port     = data.aws_ssm_parameter.db_port.value

  vpc_security_group_ids = [module.rds-sg.security_group_id]

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = []

  tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
  }
}