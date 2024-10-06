#########################
# S3
#########################
# NOTE: バケットポリシーではなくLambdaやIAMユーザーなどアクセスする側に権限付与する設計
module "backend-source-private-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "gourmet-liff-app-backend-source-public-bucket"
}

# NOTE: OACを設定して、バケットポリシーでOACからのアクセスのみを許可するように制御する設計
# TODO: CloudFront、OAC、OACからのアクセスを許可するバケットポリシーするの作成が必要(OACはバケットポリシーじゃないと制御できない)
module "frontend-source-private-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "gourmet-liff-app-frontend-source-private-bucket"
}

module "photo-private-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "gourmet-liff-app-photo-private-bucket"
}