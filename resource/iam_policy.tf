#########################
# IAM Policy
#########################
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [
        "ec2.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy" "systems_manager" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "lambda_execution" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy" "rds" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
}

data "aws_iam_policy" "s3" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy" "kms_policy" {
  name = "GourmetLiffAppKmsPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "kms:Decrypt"
        Resource = "arn:aws:kms:ap-northeast-1:328715503375:key/899d88cd-64d5-46f9-be6f-69b3500d2c59"
      }
    ]
  })
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name = "GourmetLiffAppSecretsManagerPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": "secretsmanager:GetSecretValue",
        "Resource": "arn:aws:secretsmanager:ap-northeast-1:328715503375:secret:rds!db-ef958bbc-fc70-4816-9cfb-8a0339540f73-ukWF6u"
      }
    ]
  })
}