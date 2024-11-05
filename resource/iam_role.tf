#########################
# IAM Role
#########################
// 踏み台サーバー用のIAMロール
resource "aws_iam_role" "bastion" {
  name               = "gourmet-liff-app-bastion-instance-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
resource "aws_iam_role_policy_attachment" "bastion_ssm" {
  role       = aws_iam_role.bastion.name
  policy_arn = data.aws_iam_policy.systems_manager.arn
}

// Lambda用のIAMロール
// NOTE: LambdaへのアタッチはSAMで管理
resource "aws_iam_role" "lambda" {
  name               = "gourmet-liff-app-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = data.aws_iam_policy.lambda_execution.arn
}
resource "aws_iam_role_policy_attachment" "lambda_rds" {
  role       = aws_iam_role.lambda.name
  policy_arn = data.aws_iam_policy.rds.arn
}
resource "aws_iam_role_policy_attachment" "lambda_s3" {
  role       = aws_iam_role.lambda.name
  policy_arn = data.aws_iam_policy.s3.arn
}
resource "aws_iam_role_policy_attachment" "lambda_secrets_manager" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}
resource "aws_iam_role_policy_attachment" "lambda_kms" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.kms_policy.arn
}