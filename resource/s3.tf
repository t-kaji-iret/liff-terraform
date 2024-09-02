# プライベートバケット

# バックエンドのソースを保存する
# NOTE: バケットポリシーではなくLambdaやIAMユーザーなどアクセスする側に権限付与する設計
resource "aws_s3_bucket" "private-backend" {
  bucket = "gourmet-liff-app-backend-source-bucket"
}
resource "aws_s3_bucket_public_access_block" "private-backend" {
  bucket = aws_s3_bucket.private-backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# NOTE: OAIを設定して、バケットポリシーでOAIからのアクセスのみを許可するように制御する設計
# TODO: CloudFront、OAC、OACからのアクセスを許可するバケットポリシーするの作成が必要(OACはバケットポリシーじゃないと制御できない)
# フロントエンドのソースを保存するバケット
resource "aws_s3_bucket" "private-frontend" {
  bucket = "gourmet-liff-app-frontend-source-bucket"
}
resource "aws_s3_bucket_public_access_block" "private-frontend" {
  bucket = aws_s3_bucket.private-frontend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 画像を保存するバケット
resource "aws_s3_bucket" "private-photo" {
  bucket = "gourmet-liff-app-photo-bucket"
}
resource "aws_s3_bucket_public_access_block" "private-photo" {
  bucket = aws_s3_bucket.private-photo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}