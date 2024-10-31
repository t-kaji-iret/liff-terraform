#########################
# S3
#########################
# NOTE: バケットポリシーではなくLambdaやIAMユーザーなどアクセスする側に権限付与する設計
module "backend-source-private-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "gourmet-liff-app-backend-source-public-bucket"
}

# NOTE: OACを設定して、バケットポリシーでOACからのアクセスのみを許可するように制御する設計
module "frontend-source-private-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "gourmet-liff-app-frontend-source-private-bucket"

  attach_policy = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          "Service" : "cloudfront.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          module.frontend-source-private-bucket.s3_bucket_arn,
          "${module.frontend-source-private-bucket.s3_bucket_arn}/*"
        ]
        Condition = {
          StringEquals = {
            "aws:SourceArn" = module.cloudfront.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}

module "photo-private-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "gourmet-liff-app-photo-private-bucket"

  attach_policy = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          "Service" : "cloudfront.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          module.photo-private-bucket.s3_bucket_arn,
          "${module.photo-private-bucket.s3_bucket_arn}/*"
        ]
        Condition = {
          StringEquals = {
            "aws:SourceArn" = module.cloudfront.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}