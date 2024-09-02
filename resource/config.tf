terraform {
  # terraformの必要バージョンの指定
  required_version = ">= 1.9.5"

  # providerの必要バージョンの指定
  # providerとは、terraformが操作できるクラウド(AWS,GCなど)のインターフェース
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.61.0"
    }
  }
}

provider "aws" {
  # providerで利用するリージョンを指定
  region  = "ap-northeast-1"
}