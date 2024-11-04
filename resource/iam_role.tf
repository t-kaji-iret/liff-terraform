#########################
# IAM Role
#########################
// 踏み台サーバー用のIAMロール
resource "aws_iam_role" "bastion" {
  name               = "gourmet-liff-app-bastion-instance-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion.name
  policy_arn = data.aws_iam_policy.systems_manager.arn
}

// Lambda用のIAMロール
// NOTE: LambdaへのアタッチはSAMで管理
resource "aws_iam_role" "lambda" {
  name               = "gourmet-liff-app-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
// NOTE: Lambdaへのポリシーアタッチは以下で設定する
# resource "aws_iam_role_policy_attachment" "lambda" {
#   role       = aws_iam_role.lambda.name
#   policy_arn = data.aws_iam_policy.systems_manager.arn
# }