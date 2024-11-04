#########################
# data
#########################
#########################
# パラメータストアの値
# NOTE: シークレット情報はパラメータストアに保管して参照するようにする
#########################
data "aws_ssm_parameter" "db_name" {
  name = "/gourmet_liff_app/db/name"
}
data "aws_ssm_parameter" "db_username" {
  name = "/gourmet_liff_app/db/username"
}
data "aws_ssm_parameter" "db_password" {
  name = "/gourmet_liff_app/db/password"
}
data "aws_ssm_parameter" "db_port" {
  name = "/gourmet_liff_app/db/port"
}