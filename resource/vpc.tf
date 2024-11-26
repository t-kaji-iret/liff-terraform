#########################
# VPC
#########################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "gourmet-liff-app-vpc"
  cidr = "10.0.0.0/16"

  azs              = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets   = ["10.0.101.0/24"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
  }
}

#########################
# VPC EndPoint
#########################
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
    Name     = "gourmet-liff-app-s3-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = module.vpc.private_route_table_ids[0]
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids = [module.vpc.private_subnets[0]]

  security_group_ids = [
    module.vpc-endpoint-sg.security_group_id
  ]

  private_dns_enabled = true

  tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
    Name     = "gourmet-liff-app-ec2-endpoint"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = [module.vpc.private_subnets[0]]

  security_group_ids = [
    module.vpc-endpoint-sg.security_group_id
  ]

  private_dns_enabled = true

  tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
    Name     = "gourmet-liff-app-ssm-endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [module.vpc.private_subnets[0]]

  security_group_ids = [
    module.vpc-endpoint-sg.security_group_id
  ]

  private_dns_enabled = true

  tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
    Name     = "gourmet-liff-app-ec2-messages-endpoint"
  }
}

resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [module.vpc.private_subnets[0]]

  security_group_ids = [
    module.vpc-endpoint-sg.security_group_id
  ]

  private_dns_enabled = true

    tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
    Name     = "gourmet-liff-app-ssm-messages-endpoint"
  }
}

resource "aws_vpc_endpoint" "secrets_manager" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids = [module.vpc.private_subnets[0]]

  security_group_ids = [
    module.vpc-endpoint-sg.security_group_id
  ]

  private_dns_enabled = true

    tags = {
    Terraform = "true"
    Project   = "gourmet-liff-app"
    Name     = "gourmet-liff-app-secretsmanager-endpoint"
  }
}